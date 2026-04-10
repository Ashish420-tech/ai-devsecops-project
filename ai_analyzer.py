import json

with open('result.json') as f:
    data = json.load(f)

vulns = []

for result in data.get("Results", []):
    for v in result.get("Vulnerabilities", []) or []:
        if v["Severity"] in ["CRITICAL", "HIGH"]:
            vulns.append({
                "package": v["PkgName"],
                "severity": v["Severity"],
                "title": v["Title"]
            })

print("🚨 High Risk Vulnerabilities:\n")

for v in vulns:
    print(f"{v['package']} | {v['severity']} | {v['title']}")

print("\n💡 Suggested Fix:")
print("👉 Update base image or run apk upgrade")
