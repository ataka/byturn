# coding: utf-8
#
# セットアップ用のタスク
#
desc "セットアップを行なう"
task :setup => %w[
     gem:setup
     pod:setup
]

namespace :gem do
  desc "Gem をインストールする"
  task :setup do
    sh "bundle -j4 --path vendor/bundle"
  end
end

namespace :pod do
  desc "Pod をインストールする"
  task :setup do
    sh "bundle exec pod install"
  end
end
