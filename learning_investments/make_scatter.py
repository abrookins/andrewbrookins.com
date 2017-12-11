import csv
import json
import sys


def make_scatter(filename):
    with open(filename) as f:
        reader = csv.DictReader(f)
        out = []

        for r in reader:
            returns = float(r['Satisfaction']) + \
                float(r['Joy']) + float(r['Stability']) + float(r['Benefit to Others'])
            cost = float(r['Units Invested'])

            out.append({
                'name': r['Investment'],
                'x': float(r['Age (Years)']),
                'y': (returns - cost) / float(r['Units Invested']),
                'z': cost
            })
        return json.dumps(out)


if __name__ == '__main__':
    print(make_scatter(sys.argv[1]))
