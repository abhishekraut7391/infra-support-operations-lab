# First-Level Troubleshooting Workflow

Use this sequence for practice incidents. Follow the organization's procedures and authorization boundaries in real environments.

## 1. Clarify

- What is failing, and what is the exact error?
- When did it begin? Include timezone.
- Who or what is affected? Is the impact isolated or widespread?
- What changed recently?

## 2. Establish scope

Identify the affected application, host, environment, user group, and dependency. Avoid guessing at root cause.

## 3. Collect read-only evidence

Use relevant checks such as:

```bash
date
uptime
free -h
df -h
ip addr
ip route
```

Check service status and recent logs when authorized.

## 4. Test one layer at a time

Separate DNS resolution, routing, port reachability, service state, application response, and authentication. Record the exact command and result.

## 5. Decide and communicate

Compare observations with the expected baseline. If a change, elevated access, or specialist knowledge is required, escalate with evidence instead of improvising.

## 6. Document

Record impact, timestamps, checks, outputs, actions, approvals, current status, and next owner. Distinguish confirmed facts from hypotheses.
