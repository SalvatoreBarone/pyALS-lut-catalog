import math
import sqlite3


def string_to_nested_list_int(s):
    if s == '[[], []]':
        return [[], []]
    l = [sl.strip('[]').split(',') for sl in s.split('], [')]
    return [[int(i) for i in l[0]], [int(i) for i in l[1]]]


if __name__ == '__main__':
    old_db = sqlite3.connect('lut_catalog.db')
    new_db = sqlite3.connect('lut_catalog_depth.db')

    old_cur = old_db.cursor()
    new_cur = new_db.cursor()

    new_cur.execute('CREATE TABLE luts (spec text not null, distance integer not null, synth_spec text, S text, P text, out_p integer, out integer, depth integer, primary key (spec, distance));')

    old_luts = old_cur.execute('SELECT * FROM luts')
    for row in old_luts:
        num_ins = int(math.log2(len(row[0]))) + 1
        gates = list(zip(*string_to_nested_list_int(row[3])))
        num_nodes = num_ins + len(gates)

        depth = [0] * num_nodes
        for i, gate in zip(range(num_ins, num_nodes), gates):
            depth[i] = max(depth[gate[0]], depth[gate[1]]) + 1

        new_row = (*row, depth[-1])
        new_cur.execute(f"INSERT INTO luts VALUES ('{new_row[0]}',{new_row[1]},'{new_row[2]}','{new_row[3]}','{new_row[4]}',{new_row[5]},{new_row[6]},{new_row[7]})")

    old_db.close()
    new_db.commit()
    new_db.close()
