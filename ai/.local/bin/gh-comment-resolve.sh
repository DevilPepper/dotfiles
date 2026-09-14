#!/usr/bin/env bash

# use this script to resolve a github thread by id
threadId=$1

gh api graphql \
  -F threadId=$threadId \
  -f query='
    mutation($threadId:ID!) {
      resolveReviewThread(input: {threadId:$threadId}) {
        thread {
          isResolved
        }
      }
    }
  '
