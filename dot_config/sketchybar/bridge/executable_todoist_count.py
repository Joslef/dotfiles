#!/usr/bin/env python3
import json, os, urllib.request

token_path = os.path.expanduser("~/.config/secrets/todoist_token")
token = open(token_path).read().strip()
headers = {"Authorization": f"Bearer {token}"}

# Get projects to exclude
exclude_names = {"Einkaufsliste", "Familienliste"}
req = urllib.request.Request("https://api.todoist.com/api/v1/projects", headers=headers)
projects = json.loads(urllib.request.urlopen(req, timeout=10).read())
exclude_ids = {p["id"] for p in projects.get("results", []) if p["name"] in exclude_names}

# Count tasks excluding those projects
total = 0
cursor = None
while True:
    url = "https://api.todoist.com/api/v1/tasks"
    if cursor:
        url += f"?cursor={cursor}"
    req = urllib.request.Request(url, headers=headers)
    d = json.loads(urllib.request.urlopen(req, timeout=10).read())
    total += sum(1 for t in d.get("results", []) if t.get("project_id") not in exclude_ids)
    cursor = d.get("next_cursor")
    if not cursor:
        break
print(total)
