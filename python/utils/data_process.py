import os
import pandas as pd

def sort_key(item):
    return item[-2:]


def get_data(args):
    data = {}
    for excel in os.listdir(args["data_path"]):
        data_name = os.path.splitext(excel)[0]
        data[data_name] = pd.read_excel(os.path.join(args["data_path"], excel), header=None)
    return data


def create_sat_dict(data):
    sat = set()
    for key, value in data.items():
        string_columns = value.select_dtypes(include=['object'])
        for col in string_columns.columns:
            sat.update(string_columns[col][string_columns[col] != 0])

    sat = sorted([s.replace("'", "") for s in sat], key=sort_key)
    sat_to_id = {j:i for i, j, in enumerate(sat, start=1)}
    id_to_sat = {i:j for i, j, in enumerate(sat, start=1)}
    sat_to_id.update(id_to_sat)
    return sat_to_id, len(sat)


def create_sat_set(data, sat_to_id):
    sat_set = {}
    st_per_num = []
    for key, value in enumerate(data.values()):
        sat_set[key] = {}
        string_columns = value.select_dtypes(include=['object'])
        for idx, row in enumerate(string_columns.index):
            sat_set[key][idx] = [sat_to_id[r.replace("'", "")] for r in string_columns.iloc[row] if isinstance(r, str)]
        st_per_num.append(idx+1)
    return sat_set, st_per_num


def create_time_set(data):
    time_set = {}
    for key, value in enumerate(data.values()):
        time_set[key] = {}
        int_columns = value.select_dtypes(include=['float'])
        for idx, row in enumerate(int_columns.index):
            time_set[key][idx] = [time for time in int_columns.iloc[row] if time != 0.0]

    return time_set
