# Deploying

- The `master` branch is stale and no longer used
- The `develop` branch is the active branch from which releases are made
- GitHub Actions is being used as CI to automatically test work before it's merged into `develop`
- Deployments are invoked manually through the AWS Console. The account is owned and run by the team at Warwick Business School
- There is no staging environment
- The released app is running within a Docker container
