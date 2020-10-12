Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "ExpandableCollapsable"
s.summary = "This project allows you to create stackable cards with expanding collapsing animation"

s.requires_arc = true

s.version = "0.0.2"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Sanchit Goel" => "sanch.goel@gmail.com" }

s.homepage = "https://github.com/sanchgoel/ExpandableCollapsable"

s.source = { :git => "https://github.com/sanchgoel/ExpandableCollapsable.git",
             :tag => "#{s.version}" }

s.framework = "UIKit"

s.source_files = "ExpandableCollapsableCards/Utils/**/*.{swift}"

s.swift_version = "5.0"

end
