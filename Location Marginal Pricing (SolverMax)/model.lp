\ Model LMP_NO_model
\ LP format - for model browsing. Use MPS format to capture full model detail.
\ Signature: 0xc2db95e78a50b4d6
Minimize
  total_supply_cost + total_trans_cost
Subject To
 demand_satisfied_at_every_node_Node_1: Node_Supply_used[Node_1]
   + Node_Inflow[Node_1] - Node_Outflow[Node_1] = 0
 demand_satisfied_at_every_node_Node_2: Node_Supply_used[Node_2]
   + Node_Inflow[Node_2] - Node_Outflow[Node_2] = 40000
 demand_satisfied_at_every_node_Node_3: Node_Supply_used[Node_3]
   + Node_Inflow[Node_3] - Node_Outflow[Node_3] = 30000
 demand_satisfied_at_every_node_Node_4: Node_Supply_used[Node_4]
   + Node_Inflow[Node_4] - Node_Outflow[Node_4] = 20000
 demand_satisfied_at_every_node_Node_5: Node_Supply_used[Node_5]
   + Node_Inflow[Node_5] - Node_Outflow[Node_5] = 25000
 demand_satisfied_at_every_node_Node_6: Node_Supply_used[Node_6]
   + Node_Inflow[Node_6] - Node_Outflow[Node_6] = 50000
 supply_respected_at_every_node_Node_1: Node_Supply_used[Node_1] <= 100000
 supply_respected_at_every_node_Node_2: Node_Supply_used[Node_2] <= 60000
 supply_respected_at_every_node_Node_3: Node_Supply_used[Node_3] <= 25000
 supply_respected_at_every_node_Node_4: Node_Supply_used[Node_4] <= 0
 supply_respected_at_every_node_Node_5: Node_Supply_used[Node_5] <= 0
 supply_respected_at_every_node_Node_6: Node_Supply_used[Node_6] <= 0
 supply_outflow_from_node_Node_1: Node_Outflow[Node_1]
   - Arc_flow[Node_1,Node_2] - Arc_flow[Node_1,Node_3] = 0
 supply_outflow_from_node_Node_2: Node_Outflow[Node_2]
   - Arc_flow[Node_2,Node_4] - Arc_flow[Node_2,Node_5]
   - Arc_flow[Node_2,Node_1] = 0
 supply_outflow_from_node_Node_3: Node_Outflow[Node_3]
   - Arc_flow[Node_3,Node_4] - Arc_flow[Node_3,Node_1] = 0
 supply_outflow_from_node_Node_4: Node_Outflow[Node_4]
   - Arc_flow[Node_4,Node_5] - Arc_flow[Node_4,Node_6]
   - Arc_flow[Node_4,Node_2] - Arc_flow[Node_4,Node_3] = 0
 supply_outflow_from_node_Node_5: Node_Outflow[Node_5]
   - Arc_flow[Node_5,Node_6] - Arc_flow[Node_5,Node_2]
   - Arc_flow[Node_5,Node_4] = 0
 supply_outflow_from_node_Node_6: Node_Outflow[Node_6]
   - Arc_flow[Node_6,Node_4] - Arc_flow[Node_6,Node_5] = 0
 supply_inflow_to_node_Node_1: Node_Inflow[Node_1]
   - 0.955 Arc_flow[Node_2,Node_1] - 0.93 Arc_flow[Node_3,Node_1] = 0
 supply_inflow_to_node_Node_2: Node_Inflow[Node_2]
   - 0.955 Arc_flow[Node_1,Node_2] - 0.9696 Arc_flow[Node_4,Node_2]
   - 0.985 Arc_flow[Node_5,Node_2] = 0
 supply_inflow_to_node_Node_3: Node_Inflow[Node_3]
   - 0.93 Arc_flow[Node_1,Node_3] - 0.976 Arc_flow[Node_4,Node_3] = 0
 supply_inflow_to_node_Node_4: Node_Inflow[Node_4]
   - 0.9696 Arc_flow[Node_2,Node_4] - 0.976 Arc_flow[Node_3,Node_4]
   - 0.989 Arc_flow[Node_5,Node_4] - 0.9865 Arc_flow[Node_6,Node_4] = 0
 supply_inflow_to_node_Node_5: Node_Inflow[Node_5]
   - 0.985 Arc_flow[Node_2,Node_5] - 0.989 Arc_flow[Node_4,Node_5]
   - 0.9814 Arc_flow[Node_6,Node_5] = 0
 supply_inflow_to_node_Node_6: Node_Inflow[Node_6]
   - 0.9865 Arc_flow[Node_4,Node_6] - 0.9814 Arc_flow[Node_5,Node_6] = 0
 Arc_('Node_1',_'Node_2')_capacity_not_exceeded: Arc_flow[Node_1,Node_2]
   <= 80000
 Arc_('Node_1',_'Node_3')_capacity_not_exceeded: Arc_flow[Node_1,Node_3]
   <= 40000
 Arc_('Node_2',_'Node_1')_capacity_not_exceeded: Arc_flow[Node_2,Node_1]
   <= 80000
 Arc_('Node_2',_'Node_4')_capacity_not_exceeded: Arc_flow[Node_2,Node_4]
   <= 50000
 Arc_('Node_2',_'Node_5')_capacity_not_exceeded: Arc_flow[Node_2,Node_5]
   <= 20000
 Arc_('Node_3',_'Node_1')_capacity_not_exceeded: Arc_flow[Node_3,Node_1]
   <= 40000
 Arc_('Node_3',_'Node_4')_capacity_not_exceeded: Arc_flow[Node_3,Node_4]
   <= 90000
 Arc_('Node_4',_'Node_2')_capacity_not_exceeded: Arc_flow[Node_4,Node_2]
   <= 50000
 Arc_('Node_4',_'Node_3')_capacity_not_exceeded: Arc_flow[Node_4,Node_3]
   <= 90000
 Arc_('Node_4',_'Node_5')_capacity_not_exceeded: Arc_flow[Node_4,Node_5]
   <= 20000
 Arc_('Node_4',_'Node_6')_capacity_not_exceeded: Arc_flow[Node_4,Node_6]
   <= 50000
 Arc_('Node_5',_'Node_2')_capacity_not_exceeded: Arc_flow[Node_5,Node_2]
   <= 20000
 Arc_('Node_5',_'Node_4')_capacity_not_exceeded: Arc_flow[Node_5,Node_4]
   <= 20000
 Arc_('Node_5',_'Node_6')_capacity_not_exceeded: Arc_flow[Node_5,Node_6]
   <= 60000
 Arc_('Node_6',_'Node_4')_capacity_not_exceeded: Arc_flow[Node_6,Node_4]
   <= 50000
 Arc_('Node_6',_'Node_5')_capacity_not_exceeded: Arc_flow[Node_6,Node_5]
   <= 60000
 Total_trans_cost: - 0.15 Arc_flow[Node_1,Node_2]
   - 0.3 Arc_flow[Node_1,Node_3] - 0.228 Arc_flow[Node_2,Node_4]
   - 0.12 Arc_flow[Node_2,Node_5] - 0.144 Arc_flow[Node_3,Node_4]
   - 0.125 Arc_flow[Node_4,Node_5] - 0.06 Arc_flow[Node_4,Node_6]
   - 0.066 Arc_flow[Node_5,Node_6] - 0.15 Arc_flow[Node_2,Node_1]
   - 0.3 Arc_flow[Node_3,Node_1] - 0.228 Arc_flow[Node_4,Node_2]
   - 0.12 Arc_flow[Node_5,Node_2] - 0.144 Arc_flow[Node_4,Node_3]
   - 0.125 Arc_flow[Node_5,Node_4] - 0.06 Arc_flow[Node_6,Node_4]
   - 0.066 Arc_flow[Node_6,Node_5] + total_trans_cost = 0
 Total_supply_cost: - 0.8 Node_Supply_used[Node_1]
   - 1.05 Node_Supply_used[Node_2] - 0.9 Node_Supply_used[Node_3]
   - 1.1 Node_Supply_used[Node_4] - 1.12 Node_Supply_used[Node_5]
   - 1.15 Node_Supply_used[Node_6] + total_supply_cost = 0
Bounds
End
