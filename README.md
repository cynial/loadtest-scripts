# wrk/k6 脚本集合
## wrk
### 场景1：单个接口压测
- 正常运行
`wrk --latency -c1 -d1s -t1 https://weibo.com`
- 调试查看 request 和 response
`wrk --latency -c1 -d1s -t1 -s ./scripts/debug.lua https://weibo.com`
### 场景2：多个 cookie 混压
- 正常运行
`wrk -H --latency -c1 -d1s -t1 -s ./scripts/cookie.lua https://weibo.com`
- 调试查看 request 和 response
`wrk -H --latency -c1 -d1s -t1 -s ./scripts/cookie.lua https://weibo.com -- debug`
### 参考
- https://github.com/czerasz/wrk-debugging-environment/blob/master/environments/wrk/scripts/debug.lua
- https://github.com/timotta/wrk-scripts/blob/master/multiplepaths.lua
