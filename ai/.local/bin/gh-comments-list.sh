#!/usr/bin/env bash

# Use this script to list unresolved PR comments not written by me (json) whether they are inline or not
# Inline scripts have thread_id, path, and line; while issue comments have these set to null
pr=$(gh pr view --json number -q .number)
me=$(git config user.name)

gh api graphql -F owner="{owner}" -F repo="{repo}" -F pr="${pr}" \
  -f query='
    query($owner: String!, $repo: String!, $pr: Int!) {
      repository(owner: $owner, name: $repo) {
        pullRequest(number: $pr) {
          comments(last: 100) {
            nodes {
              databaseId
              createdAt
              updatedAt
              author { login }
            }
          }
          reviews(last: 100) {
            nodes {
              databaseId
              state
              createdAt
              updatedAt
              author { login }
            }
          }
          # commits(last: 100) {
          #   nodes {
          #     commit {
          #       oid
          #       comments(first: 50) {
          #         nodes {
          #           databaseId
          #           id
          #           body
          #           path
          #           position
          #           createdAt
          #           author { login }
          #         }
          #       }
          #     }
          #   }
          # }
          reviewThreads(last: 100) {
            nodes {
              id
              isResolved
              comments(last: 100) {
                nodes {
                  databaseId
                  path
                  line
                  createdAt
                  updatedAt
                  state
                  author { login }
                }
              }
            }
          }
        }
      }
    }
  ' \
  | jq --arg me "$me" '
      .data.repository.pullRequest as $pr
      | [
        ($pr.reviews.nodes[]
        | select(.author.login != $me)
        | {
            id: .databaseId,
            thread_id: null,
            path: null,
            line: null,
            state: .state,
            created_at: .createdAt,
            updated_at: .updatedAt,
            user_login: .author.login
          }
        ),
        ($pr.comments.nodes[]
        | select(.author.login != $me)
        | {
            id: .databaseId,
            thread_id: null,
            path: null,
            line: null,
            state: null,
            created_at: .createdAt,
            updated_at: .updatedAt,
            user_login: .author.login
          }
        ),
        ($pr.reviewThreads.nodes[]
        | select(.isResolved == false)
        | .id as $thread_id
        | .comments.nodes[]
        | select(.author.login != $me)
        | {
            thread_id: $thread_id,
            id: .databaseId,
            path,
            line,
            state: .state,
            created_at: .createdAt,
            updated_at: .updatedAt,
            username: .author.login
          }
        )
      ]
    '
