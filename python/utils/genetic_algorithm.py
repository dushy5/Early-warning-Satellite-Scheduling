import math
import random
import numpy as np

class GeneticAlgorithm:

    def __init__(self, args):
        self.args = args
        self.st_total_num = sum(args["st_per_num"])
        self.target_num = len(args["sat_set"])
        self.st_cumsum = np.cumsum(np.array(self.args["st_per_num"]))

    def create_random_st_series(self):
        data_list = []
        for i, st in enumerate(self.args["st_per_num"], start=1):
            data_list = data_list + [i for _ in range(st)]
        st_series = np.array(data_list)
        np.random.shuffle(st_series)
        return st_series


    def create_random_sat_series(self, clone_chrom):
        data_list = np.array([0] * self.st_total_num * 2)
        flag = 0
        for idx, value in enumerate(self.args["st_per_num"]):
            sat_set = self.args["sat_set"][idx]
            for i in range(value):
                # 第一颗卫星
                data_list[flag] = random.randint(0, len(sat_set[i]) - 1)
                times = 0
                while self.check_if_overlap(data_list[:flag+1]):
                    if times > self.st_total_num : break
                    data_list[flag] = random.randint(0, len(sat_set[i]) - 1)
                    times += 1
                if times > self.st_total_num:
                    data_list = clone_chrom
                    break

                # 第二颗卫星
                data_list[flag + 1] = random.randint(0, len(sat_set[i]) - 1)
                times = 0
                while data_list[flag] == data_list[flag + 1] or self.check_if_overlap(data_list[:flag+2]):
                    if times > self.st_total_num: break
                    data_list[flag + 1] = random.randint(0, len(sat_set[i]) - 1)
                    times += 1
                if times > self.st_total_num:
                    data_list = clone_chrom
                    break
                flag = flag + 2
        return data_list


    def check_if_overlap(self, chrom):
        cur = chrom.shape[0]-1
        st_new_cum = np.insert(self.st_cumsum, 0, 0)
        st_cumsum = np.insert(np.cumsum(np.array(self.args["st_per_num"])*2), 0, 0)
        for i in range(0, cur):
            t1 = find_max_smaller_index(st_cumsum, cur)
            s1 = math.floor(cur / 2 - st_new_cum[t1])
            t2 = find_max_smaller_index(st_cumsum, i)
            s2 = math.floor(i / 2 - st_new_cum[t2])
            if self.args["sat_set"][t1][s1][int(chrom[cur])] == self.args["sat_set"][t2][s2][int(chrom[i])]:
                if time_overlap(self.args["time_set"][t1][s1], self.args["time_set"][t2][s2]):
                    return True
        return False


    def calculate_switch_num(self, chrom):
        switch_num = 0
        left = 0
        right = 1
        for i, num in enumerate(self.args["st_per_num"]):
            for j, _ in enumerate(range(num-1)):
                judgement1 = self.args["sat_set"][i][j][int(chrom[left])] != self.args["sat_set"][i][j + 1][int(chrom[left + 2])] \
                and self.args["sat_set"][i][j][int(chrom[right])] == self.args["sat_set"][i][j + 1][int(chrom[right + 2])]
                judgement2 = self.args["sat_set"][i][j][int(chrom[left])] == self.args["sat_set"][i][j + 1][int(chrom[left + 2])] \
                and self.args["sat_set"][i][j][int(chrom[right])] != self.args["sat_set"][i][j + 1][int(chrom[right + 2])]
                judgement3 = self.args["sat_set"][i][j][int(chrom[left])] != self.args["sat_set"][i][j + 1][int(chrom[left + 2])] \
                and self.args["sat_set"][i][j][int(chrom[right])] != self.args["sat_set"][i][j + 1][int(chrom[right + 2])]
                if judgement1 or judgement2:
                    switch_num += 1
                elif judgement3:
                    switch_num +=2
            left += 2
            right +=2
        return switch_num


    def calculate_obj(self, chroms):
        obj_value = list()
        for chrom in chroms:
            obj_value.append(self.calculate_switch_num(chrom[self.st_total_num:]))
        return np.array(obj_value)


    def generate_init(self):
        chroms = np.zeros((self.args["chrom_size"], 3 * self.st_total_num))
        clone_chrom = chroms[0][self.st_total_num:]
        for chrom in chroms:
            chrom[:self.st_total_num] = self.create_random_st_series()
            chrom[self.st_total_num:] = self.create_random_sat_series(clone_chrom)
            clone_chrom = chrom[self.st_total_num:]
        return chroms


    def selection(self, chroms, obj_value):
        px, py = chroms.shape
        new_chroms = np.zeros((px, py))
        flag = 0
        while flag < px:
            for i in range(0, px, 2):
                min_ind = np.argmin(obj_value[i:i+2])
                new_chroms[flag] = chroms[min_ind + i]
                flag += 1
        return new_chroms


    def crossover(self):
        pass


    def mutation(self):
        pass


    def main_iteration(self):
        gen = 1
        init_chroms = self.generate_init()

        while gen < self.args["max_gen"]:
            obj_value = self.calculate_obj(init_chroms)

            chroms = self.selection(init_chroms, obj_value)

            gen += 1


    # def check_if_overlap(self, chrom):
    #     st_new_cum = np.insert(np.cumsum(np.array(self.args["st_per_num"])), 0, 0)
    #     st_cumsum = np.insert(np.cumsum(np.array(self.args["st_per_num"])*2), 0, 0)
    #     for i in range(st_cumsum[1], chrom.shape[0]+1):
    #         t1 = find_max_smaller_index(st_cumsum, i)
    #         s1 = math.floor(i / 2 - st_new_cum[t1])
    #         for j in range(0, i):
    #             t2 = find_max_smaller_index(st_cumsum, j)
    #             s2 = math.floor(j / 2 - st_new_cum[t2])
    #             if self.args["sat_set"][t1][s1][int(chrom[i])] == self.args["sat_set"][t2][s2][int(chrom[j])]:
    #                 if time_overlap(self.args["time_set"][t1][s1], self.args["time_set"][t2][s2]):
    #                     print([t1,s1,t2,s2])
    #                     return True
    #     return False

def time_overlap(set1, set2):
    if set1[0] >= set2[1] or set2[0] >= set1[1]:
        return False
    else:
        return True


def find_max_smaller_index(cumsum, target):
    max_smaller_index = -1
    for i, num in enumerate(cumsum):
        if num <= target:
            max_smaller_index = i
    return max_smaller_index