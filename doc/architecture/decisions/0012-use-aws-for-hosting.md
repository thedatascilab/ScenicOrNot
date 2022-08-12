# 1. use-aws-for-hosting

Date: 2022-04-07

## Status

Accepted

## Context

This ADR is to document a past decision retrospectively for reference.

The Scenic Or Not Rails application is being introduced to replace an old,
legacy PHP application, which is over ten years old. The team responsible for
maintaining the application are comfortable with AWS, and are happy to manually
deploy the application. This may be reviewed in the future.

## Decision

The hosting of the live service will exist in an AWS account owned and
maintained by the Warwick Business School.

## Consequences

This will require manual deployment of the application each time code changes
are made.

There is a risk with personnel changes, that any new people may not have the
same knowledge as the existing team, so may not be able to deploy the
application.

Also, any security updates may not be deployed as rapidly without a CI pipeline.

This is something we will review as the project matures.
