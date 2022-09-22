# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

desc "Run all the tests"
task default: %i[spec standard]

namespace :app do
  desc "Generate static pages"
  task static: :environment do
    Rails.application.config.action_controller.perform_caching = false
    pages = {
      "pages/errors/404" => "404.html",
      "pages/errors/422" => "422.html",
      "pages/errors/500" => "500.html",
      # TODO: Generate this page, inlining all assets (CSS, JS, and images as data URLs)
      # "pages/errors/503" => "503.html"
    }

    pages.each do |page, output|
      puts "Generating #{output}..."

      html = ApplicationController.render(template: page, layout: "layouts/application")

      if html.present?
        output_path = Rails.root.join("public", output)

        File.delete(output_path) if File.exist?(output_path)
        File.write(output_path, html)
      else
        puts "Error generating #{output}!"
      end
    end
  end
end
