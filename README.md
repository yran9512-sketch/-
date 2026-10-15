# 心动校园

手机优先的校园表白墙，使用 Supabase 保存投稿。所有新投稿默认进入待审核状态，只有管理员在 Supabase 将 status 改为 approved 后才会公开显示。

## 部署到 Vercel
1. 在 Vercel 选择 Add New → Project，导入此 GitHub 仓库。
2. 本项目是单页静态 HTML，无需 Build Command；Output Directory 留空或设为 `.`。
3. 部署后访问 Vercel 分配的网址。

## 数据库
Supabase 项目已在此前配置。网页只使用 Publishable key（可公开的客户端 key），绝不要放 service_role/secret key。
目前数据库连接信息写在 index.html 的 CONFIG 区域。如需更换学校或项目，请修改那里。

## 管理投稿
在 Supabase Dashboard → Table Editor → public.posts：
- status = pending：待审核
- status = approved：公开展示
- status = rejected：拒绝展示

举报记录位于 public.reports。

## 上线前注意
此版本没有管理员网页、验证码或速率限制。建议先小范围测试；不要公开他人联系方式、学号或未经同意的照片。