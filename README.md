# README

### table schema
| User     |        |
| -------- | ------ |
| id       | Text   |
| name     | string |
| email    | string |
| password | string |

| Task     |                                   |
| -------- | --------------------------------- |
| title    | string                            |
| content  | text                            |
| status   | enum{ pending, processing, done } |
| priority | enum{ high, normal, low }         |
| start_at | time_stamp                        |
| end_at   | time_stamp                        |

| Tag  |        |
| ---- | ------ |
| name | string |

| TaskTag |         |
| ------- | ------- |
| task_id | integer |
| tag_id  | integer |
