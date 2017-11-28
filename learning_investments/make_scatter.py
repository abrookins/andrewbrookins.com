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

            out.append({
                'name': r['Investment'],
                'x': float(r['Age (Years)']),
                'y': returns / float(r['Units Invested']),
                'z': float(r['Units Invested'])
            })
        return json.dumps(out)


if __name__ == '__main__':
    data = make_scatter(sys.argv[1])
    template = sys.argv[2]
    print()
