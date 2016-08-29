# Supported tags and respective `Dockerfile` links

- [`2.102.0`, `latest`, (*Dockerfile*)](https://github.com/developertown/vsts-agent/blob/master/Dockerfile)

# Containerized VSTS Agent

This image forms the base of a series of technology-specific images that
work as private agents within Visual Studio Team Services' cloud
environment.

## How to use this image

**Note**: It is highly recommended to use the version-specific tagged images instead of `latest`, as they will track along with VSTS agent releases.

The following environment variables are required:

- `VSTS_URL`: The complete URL to your VSTS environment.  For example, `https://mycompany.visualstudio.com`.
- `VSTS_PAT_TOKEN`: The PAT token the agent should use to authenticate.

The following environment variables are optional:

- `VSTS_POOL`: The pool the agent should join.  Will join the `Default` pool if unset.
- `VSTS_AGENT_NAME`: The name the agent should register itself as in VSTS.  If unset, it will create an agent name comprised of the hostname and an epoch timestamp at time of launch.

## Example

```docker run --name vsts_agent1 -d -e VSTS_URL=https://mycompany.visualstudio.com -e VSTS_PAT_TOKEN=asdfasdfgobbledygook2512341234 -e VSTS_AGENT_NAME=agent1 developertown/vsts-agent:2.102.0```
