import pandas as pd
import gurobipy as gp
from Process_data import process_data

def create_model(supplier_df, demand_df, arc_df):
    # Create model
    model = gp.Model("LMP_NO_model")

    # Create list of origins and destinations
    nodes = supplier_df['Supplier'].to_list()
    print(nodes)

    # Create dictionaries
    # Supplier
    supplier_df = supplier_df.set_index(['Supplier'])
    supplier_dict = supplier_df.to_dict(orient = 'index')

    # for i in nodes:
    #     print(supplier_dict[i]['Max Kg'], supplier_dict[i]['$/kg'])

    # Demand
    demand_dict = demand_df.set_index(['Location'])['Demand'].to_dict()
    # print(demand_dict)

    # Transport
    arc_dict = arc_df.set_index(['Origin', 'Destination']).to_dict(orient='index')
    # for i in nodes:
    #     for j in nodes:
    #         if (i, j) in arc_dict.keys():
    #             # print(i, j)
    #             print(arc_dict[i, j])#['Max kg'])

    # Variables
    # V1 - Supply used
    v_supply =  model.addVars(nodes, lb=0, name="Node_Supply_used")

    # V2 - Inflow - where nodes are arc destinations
    v_inflow = model.addVars(nodes, lb=0, name="Node_Inflow")

    # V3 - Outflow - where nodes are arc sources
    v_outflow = model.addVars(nodes, lb=0, name="Node_Outflow")

    # V4 - Arc Flow
    v_arcFlow = model.addVars(arc_dict.keys(), lb=0, name="Arc_flow")

    # V5 - Arc Allowed - Binary to set which are is allowed
    # v_arcAllowed = model.addVars(arc_dict.keys(), vtype=gp.GRB.BINARY, name="Arc_allowed")

    # V6 - Total supply cost
    v_totalSupplyCost = model.addVar(lb=0, name="total_supply_cost")

    # V7 - Total transportation cost
    v_totalTransCost = model.addVar(lb=0, name="total_trans_cost")

    # Constraints
    # C1 - Demand satisfied at every node
    c1 = []
    for i in nodes:
        c1.append(model.addConstr(v_supply[i] + v_inflow[i] - v_outflow[i] == demand_dict[i],
                        f"demand_satisfied_at_every_node_{i}"))

    # C2 - Supply doesn't exceed max supply
    c2 = []
    for i in nodes:
        c2.append(model.addConstr(v_supply[i] <= supplier_dict[i]['Max Kg'],
                        f"supply_respected_at_every_node_{i}"))

    # C3 - Outflow from a node
    c3 = []
    for i in nodes:
       c3.append(model.addConstr(v_outflow[i] == (gp.quicksum(v_arcFlow[i,j] for j in nodes if (i,j) in arc_dict.keys())),
                        f"supply_outflow_from_node_{i}"))

    # C4 - Inflow into a node
    c4 = []
    for i in nodes:
        c4.append(model.addConstr(v_inflow[i] == (gp.quicksum(v_arcFlow[j, i] * (1 - (arc_dict[j, i]['Loss/100km'] * arc_dict[j, i]['km']/100))  for j in nodes if (i,j) in arc_dict.keys())),
                        f"supply_inflow_to_node_{i}"))


    ####---------------------*************************---------------------####
    # Note: C5 is disabled as Gurobi doesn't have the functionality to extract duals with MIPs
    ####---------------------*************************---------------------####
    # C5 - Only 1 arc allowed:
    # for i in nodes:
    #     for j in nodes:
    #         if(i, j) in arc_dict.keys() and i < j:
    #             model.addConstr(v_arcAllowed[i,j] + v_arcAllowed[j, i] == 1,
    #                             f"Only one of arc_{i, j} or {j, i}")

    # C6 - Arc doesn't exceed capacity
    c6 = []
    for i in nodes:
        for j in nodes:
            if (i,j) in arc_dict.keys():
                c6.append(model.addConstr(v_arcFlow[i, j] <= arc_dict[i, j]['Max kg'], #* v_arcAllowed[i, j],
                                f"Arc_{i, j}_capacity_not_exceeded"))

    # C7 - Assign total transportation cost
    model.addConstr(v_totalTransCost == gp.quicksum(v_arcFlow[i, j] * (arc_dict[i, j]['$/100km/kg'] * arc_dict[i, j]['km']/100) for (i, j) in arc_dict.keys()),
                    "Total_trans_cost")

    # C8 - Total Supply cost
    model.addConstr(v_totalSupplyCost == gp.quicksum(v_supply[i] * supplier_dict[i]['$/kg'] for i in nodes),
                    "Total_supply_cost")

    # Objective
    model.setObjective(v_totalTransCost + v_totalSupplyCost, gp.GRB.MINIMIZE)

    model.optimize()

    if model.status == gp.GRB.OPTIMAL:
        print(f"Optimal objective value: {model.objVal}")

        print("Flow variables:")
        for (i,j) in arc_dict.keys():
            print((i, j), v_arcFlow[i,j].X)
        # Location Marginal pricing (LMP)
        # LMP consists of: Supply cost, Transportation congestion cost (capacity constrained), Transportation Losses
        # LMP is the measure of cost of potatoes at a particular node considering the three factors above
        # A lower LMP indicates proximity to Supply, hence mitigating the effects of transportation capacity constraints and losees

        print("Printing LMPs")
        print("Duals of constraint 1 (Demand is satisfied at every node)")

        duals = [round(c.Pi, 4) for c in c1]
        for i, j in zip(duals, nodes):
            print(f"{j} $ {round(i, 2)}")

    else:
        print("Model was not optimized to optimality.")

    model.write('model.lp')


if __name__ == "__main__":
    [supplier, demand, arc] = process_data('LMP_potato_flow.xlsx')
    create_model(supplier, demand, arc)
    # print(supplier)
    # print(b)
    # print(c)