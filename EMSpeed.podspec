
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "EMSpeed"
  s.version      = "0.0.1"
  s.summary      = "A fast convenient Library for emoney projects"

  s.description  = <<-DESC
                   A longer description of EMSpeed in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/emoneycn/emspeed.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "Emoney" => "ios@emoney.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "7.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "http://ph.benemind.com/diffusion/EMSPEED/emspeed.git"}


  s.subspec 'Core' do |cs|
    cs.source_files  = "Core/**/*.{h,m,c,swift}"
    cs.resources     = "Core/resource/**/*.*"
    #cs.frameworks = "SomeFramework", "AnotherFramework"
  end

  # ------------------------------------------------------------------------------

  s.subspec 'Network' do |cs|
    cs.source_files  = "Network/**/*.{h,m,c,swift}"
    cs.resources     = "Network/resource/**/*.*"
    cs.dependency 'EMSpeed/Core'
    cs.dependency "AFNetworking", "~> 2.5.1"
  end

  # ------------------------------------------------------------------------------

  s.subspec 'FontAwesome+iOS' do |cs|
    cs.source_files  = "FontAwesome+iOS/**/*.{h,m,c,swift}"
    cs.resources     = "FontAwesome+iOS/resource/**/*.*"
  end

  s.subspec 'BDKNotifyHUD' do |cs|
    cs.source_files  = "BDKNotifyHUD/**/*.{h,m,c,swift}"
    cs.resources     = "BDKNotifyHUD/resource/**/*.*"
  end

  s.subspec 'MCSegmentedControl' do |cs|
    cs.source_files  = "MCSegmentedControl/**/*.{h,m,c,swift}"
    cs.resources     = "MCSegmentedControl/resource/**/*.*"
  end

  s.subspec 'StyledPageControl' do |cs|
    cs.source_files  = "StyledPageControl/**/*.{h,m,c,swift}"
    cs.resources     = "StyledPageControl/resource/**/*.*"
  end

  s.subspec 'MSContext' do |cs|
    cs.source_files  = "MSContext/**/*.{h,m,c,swift}"
    cs.resources     = "MSContext/resource/**/*.*"
  end

  # ------------------------------------------------------------------------------
  s.subspec 'UI' do |cs|
    cs.source_files  = "UI/**/*.{h,m,c,swift}"
    cs.resources     = "UI/resource/**/*.*"
    cs.dependency 'EMSpeed/Core'
    cs.dependency 'EMSpeed/FontAwesome+iOS'
    cs.dependency 'EMSpeed/MSContext'

    cs.dependency 'EMSpeed/BDKNotifyHUD'
    cs.dependency 'EMSpeed/MCSegmentedControl'
    cs.dependency 'EMSpeed/StyledPageControl'

    cs.dependency 'SDWebImage', '~> 3.7.2'
    cs.dependency 'MJRefresh', '~> 2.0.1'

  end

  s.subspec 'ThemeManager' do |cs|
    cs.source_files  = "Theme/**/*.{h,m,c,swift}"
    cs.resources     = "UI/resource/**/*.*"
    cs.resources     = "Theme/resource/**/*.*"
    cs.dependency 'EMSpeed/Core'
    cs.dependency 'EMSpeed/UI'
  end


  # s.public_header_files = "Classes/**/*.h"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
