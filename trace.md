# 日志格式

## 原始日志

```yaml
trace_id: string, 业务流id
task_id: string, 业务id
node_id: string, 业务节点id
timestamp: 时间戳
host_name: 主机名
host_ip: 主机ip
message: 日志信息(json格式)
```

## 邮件业务日志

原始日志 message 部分， 可能包含以下内容

```yaml
message_id: 邮件message_id
from: 发件人
to: 收件人
company_id: 公司id
mail_type: 邮件类型(认证邮件, 工单邮件)
mail_raw: 邮件原文链接
mail_temp_file: 邮件临时文件path
```

业务聚合记录

```yaml
trace_id: 业务流id
started_at: 开始时间
company_id: 公司id
message_id: 邮件message_id
status: 状态(成功、失败)
from: 邮件发件人
to: 邮件收件人
mail_raw: 邮件原文链接
mail_type: 认证邮件, 工单邮件
```
