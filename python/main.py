import os
import time
import numpy as np
from utils import *

os.chdir('python')

#参数
def parse_args(**kwargs):
    options = {
        # GA参数
        "chrom_size":200,   #染色体种群
        "max_gen":100,      #最大代数
        "cr":0.7,           #交叉概率
        "mr":0.1,           #变异概率

        # 路径参数
        "data_path":"datasets" #数据位置

        # 卫星参数
        # ...
    }
    for key, value in kwargs.items():
        options[key] = value

    return options


def main():
    
    # 参数打包
    opt = parse_args()


    # 获取数据
    data = get_data(opt)


    # 卫星字典
    sat_dict, sat_num = create_sat_dict(data)


    # 卫星集
    sat_set, st_per_num = create_sat_set(data, sat_dict)


    #时间集
    time_set = create_time_set(data)


    # 打包参数
    args = parse_args(sat_num=sat_num,          #卫星数量
                      sat_set=sat_set,          #卫星集
                      time_set=time_set,        #时间集
                      sat_dict=sat_dict,        #字典
                      st_per_num=st_per_num)    #每个目标的子任务数[8, 9, 9]
    # print(args)

    # 遗传算法
    ga_model = GeneticAlgorithm(args=args)
    ga_model.main_iteration()


if __name__ == "__main__":
    main()