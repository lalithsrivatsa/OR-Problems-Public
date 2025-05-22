import pandas as pd

def process_data(file_path):
    # Supplier data
    supplier_df = pd.read_excel(file_path, sheet_name='Supplier data')
    # print(supplier_df.head())

    # Demand data
    demand_df = pd.read_excel(file_path, sheet_name='Demand data')
    # print(demand_df.head())

    # Create a node_df
    # node_df = pd.merge(supplier_df, demand_df, how='left', left_on='Supplier', right_on='Location', suffixes=('_L', '_R'))
    # print(node_df.head())

    # Arc data
    arc_df = pd.read_excel(file_path, sheet_name='Transport data')
    arc_df_reversed = arc_df.copy()
    arc_df_reversed['Nodes'] = arc_df_reversed['Nodes'].str[::-1]
    arc_df = pd.concat([arc_df, arc_df_reversed]).reset_index(drop=True)
    split_str = arc_df['Nodes'].str.split('-', expand=True)
    arc_df['Origin'] = 'Node ' + split_str[0]
    arc_df['Destination'] = 'Node ' + split_str[1]
    # print(arc_df_reversed.head())


    return supplier_df, demand_df, arc_df

# if __name__ == "__main__":
#     [a, b, c] = process_data('LMP_potato_flow.xlsx')
#     print(a)
#     print(b)
#     print(c)