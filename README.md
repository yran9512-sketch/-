# 校园圈｜学生自由分享社区

手机优先的校园社区，供学生分享日常、校园生活、学习经验、求助互助、吐槽建议、兴趣交友和其他话题。使用 Supabase 保存内容。

## 功能
- 浏览通过审核的公开动态、按话题筛选
- 匿名昵称发布动态，默认进入待审核状态
- 点赞、举报
- 管理后台登录、审核/拒绝/删除动态、处理举报

## 网站与后台
- 网站： https://worker.yran9512.workers.dev
- 管理后台： https://worker.yran9512.workers.dev/admin.html

## 数据库与安全
网页只使用 Supabase Publishable key（可公开的客户端 key），绝不要把 service_role/secret key 放进浏览器代码。
新内容默认 status = pending，审核通过后 status = approved，拒绝为 rejected。
举报记录位于 public.reports。管理员需要在 Supabase Auth 用户的 App Metadata 中配置 `role: admin`，并使用该用户登录后台。

## 社区规则
欢迎真诚表达和不同观点；禁止公开他人隐私、骚扰、威胁、仇恨攻击、违法内容或未经同意的个人信息。请在上线前小范围测试，并根据社区规模增加验证码、速率限制和申诉机制。
