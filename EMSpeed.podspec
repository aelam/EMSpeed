
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "EMSpeed"
  s.version      = "0.0.1"
  s.summary      = "A short description of EMSpeed."

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
  s.source       = { :git => "https://github.com/emoneycn/emspeed", :tag => "#{s.version}" }


  s.subspec 'Core' do |cs|
    cs.source_files  = "Core/**/*.{h,m,c,swift}"
    cs.resources     = "Core/resource/**/*.*"
    #cs.frameworks = "SomeFramework", "AnotherFramework"
  end

  s.subspec 'Network' do |cs|
    cs.source_files  = "Network/**/*.{h,m,c,swift}"
    cs.resources     = "Network/resource/**/*.*"
    cs.dependency 'EMSpeed/Core'
    cs.dependency "AFNetworking", "~> 2.5.1"
  end

  s.subspec 'UI' do |cs|
    cs.source_files  = "UI/**/*.{h,m,c,swift}"
    cs.resources     = "UI/resource/**/*.*"
    cs.dependency 'EMSpeed/Core'
  end

  s.subspec 'ThemeManager' do |cs|
    cs.source_files  = "Theme/**/*.{h,m,c,swift}"
    cs.resources     = "UI/resource/**/*.*"
    cs.dependency 'EMSpeed/Core'
    cs.dependency 'EMSpeed/UI'
  end



  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
