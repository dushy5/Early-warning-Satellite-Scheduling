
#TODO 常改动参数
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

