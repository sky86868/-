[![构建状态](/badges/minjie/build.svg)](/p/minjie/ci/job)

[TOC]

# 体验示例项目

这个示例代码可以帮你快速了解一个简单的 Ruby on Rails 网页应用。并已经配置好自动编译过程。

文件解释
-----------

样例包括:

* app/	- 主代码文件夹
* bin/ - 包含启动 rails 的启动、设置、更新、部署脚本
* config/ - 路由、数据库等的配置文件
* config.ru - Rack 配置文件
* db/ - 数据库对象
* Gemfile
* Gemfile.lock- gem 包管理文件
* lib/ - 扩展模块
* log/ - 日志
* package.json - npm 包管理文件
* public/ - 静态文件夹
* Rakefile - 自动生成的任务文件
* README.md - 本文件
* test/ - 主测试代码
* tmp/ - 临时文件
* vendor/ - 第三方代码
* .ruby-version - 包含默认的 Ruby 版本

快速开始
---------------

如下这些引导，假定你想在自己的电脑上开发本项目。

1. 安装依赖

        $ bundle install

2. 启动服务器

        $ bundle exec rails server

3. 打开 http://127.0.0.1:3000 .
