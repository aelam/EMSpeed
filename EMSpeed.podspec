Pod::Spec.new do |s|
  s.name             = "EMSpeed"
  s.version          = "0.3.4"
  s.summary          = "EMSpeed Collections with Foundation, UIKit."

  s.description      = <<-DESC
                        EMSpeed Collections with Foundation, UIKit.
                        基础框架
                       DESC

  s.homepage         = "http://ph.benemind.com/diffusion/EMSPEED/emspeed"
  s.license          = 'MIT'
  s.author           = { "Emoney" => "ios@emoney.com" }
  s.source           = { :git => "http://ph.benemind.com/diffusion/EMSPEED/emspeed.git", :tag => s.version.to_s }

  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  s.frameworks       = 'Foundation', 'CoreGraphics'

  s.public_header_files = 'EMSpeed/Speed.h'
  s.source_files        = "EMSpeed/Speed.h"

  s.subspec 'Core' do |ss|
    ss.public_header_files  = "EMSpeed/Core/**/*.h"
    ss.source_files         = "EMSpeed/Core/**/*.{h,m,c,swift}"
    ss.frameworks           = "Security"
  end

  s.subspec 'MSContext' do |ss|
    ss.public_header_files  = "EMSpeed/MSContext/**/*.h"
    ss.source_files         = "EMSpeed/MSContext/**/*.{h,m,c,swift}"
  end

  s.subspec 'UIKit' do |ss|
    ss.public_header_files = 'EMSpeed/UIKit/MSUIKit.h'
    ss.source_files        = "EMSpeed/UIKit/MSUIKit.h"

    ss.subspec 'Core' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/Core/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/Core/**/*.{h,m,c}"
      sss.dependency          "EMSpeed/Core"
    end

    ss.subspec 'UIImages' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/UIImages/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/UIImages/**/*.{h,m,c}"
      sss.dependency          "EMSpeed/UIKit/Core"
    end

    ss.subspec 'Animations' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/Animations/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/Animations/**/*.{h,m,c}"
      sss.dependency          "EMSpeed/UIKit/Core"
    end

    ss.subspec 'UIKitCollections' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/UIKitCollections/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/UIKitCollections/**/*.{h,m,c}"
      sss.dependency          "EMSpeed/UIKit/Core"
      sss.dependency          "EMSpeed/UIKit/UIColors"
      sss.dependency          "EMSpeed/MSContext"
      sss.dependency          "Masonry"
    end

    ss.subspec 'WebImage' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/WebImage/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/WebImage/**/*.{h,m,c}"
      sss.dependency          "SDWebImage"
      sss.dependency          "EMSpeed/UIKit/UIImages"
    end

    ss.subspec 'MultiPagingView' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/MultiPagingView/src/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/MultiPagingView/src/**/*.{h,m,c}"
      sss.resources           = "EMSpeed/UIKit/MultiPagingView/resource/*"
      sss.dependency          "EMSpeed/UIKit/WebImage"
      sss.dependency          "EMSpeed/UIKit/UIKitCollections"
    end

    ss.subspec 'UIColors' do |sss|
      sss.source_files = "EMSpeed/UIKit/UIColors/**/*.h"
      sss.source_files = "EMSpeed/UIKit/UIColors/**/*.{h,m,c}"
      sss.dependency     "EMSpeed/UIKit/Core"
    end

    ss.subspec 'FontAwesome+iOS' do |sss|
      sss.public_header_files   = "EMSpeed/UIKit/FontAwesome+iOS/**/*.h"
      sss.source_files          = "EMSpeed/UIKit/FontAwesome+iOS/**/*.{h,m}"
      sss.resources             = "EMSpeed/UIKit/FontAwesome+iOS/resource/**/*.*"
    end

    ss.subspec 'PopupView' do |sss|
      sss.public_header_files   = "EMSpeed/UIKit/PopupView/**/*.h"
      sss.source_files          = "EMSpeed/UIKit/PopupView/**/*.{h,m}"
      sss.dependency            "EMSpeed/UIKit/Core"
      sss.dependency            "EMSpeed/UIKit/UIImages"
      sss.dependency            "EMSpeed/MSContext"
    end

    ss.subspec 'CollectionModels' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/CollectionModels/src/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/CollectionModels/src/**/*.{h,m}"
      sss.resources           = "EMSpeed/UIKit/CollectionModels/resource/**/*.*"
      sss.dependency          "EMSpeed/UIKit/WebImage"
      sss.dependency          "EMSpeed/Core"
    end

    ss.subspec 'TableModels' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/TableModels/**/*.h"
      sss.source_files = "EMSpeed/UIKit/TableModels/**/*.{h,m}"
      sss.dependency     "EMSpeed/UIKit/Core"
      sss.dependency     "MJRefresh"
    end

    ss.subspec 'StatusBar' do |sss|
      sss.public_header_files = "EMSpeed/UIKit/StatusBar/**/*.h"
      sss.source_files        = "EMSpeed/UIKit/StatusBar/**/*.{h,m}"
      sss.dependency          "EMSpeed/UIKit/Core"
    end

    ss.subspec 'GuideView' do |sss|
      sss.public_header_files   = "EMSpeed/UIKit/GuideView/**/*.h"
      sss.source_files          = "EMSpeed/UIKit/GuideView/**/*.{h,m}"
      sss.dependency            "EMSpeed/UIKit/Animations"
      sss.dependency            "EMSpeed/UIKit/Core"
    end

    ss.subspec 'Container' do |sss|
      sss.public_header_files   = "EMSpeed/UIKit/Container/**/*.h"
      sss.source_files          = "EMSpeed/UIKit/Container/**/*.{h,m}"
      sss.resources             = "EMSpeed/UIKit/Container/resource/*.*"
      sss.dependency            "EMSpeed/UIKit/Core"
    end
  end

  s.subspec 'Network' do |ss|
    ss.public_header_files   = "EMSpeed/Network/**/*.h"
    ss.source_files          = "EMSpeed/Network/**/*.{h,m}"
    ss.dependency           "EMSpeed/UIKit/Core"
    ss.dependency           "AFNetworking"
  end

  s.subspec 'Network2.0' do |ss|
    ss.public_header_files   = "EMSpeed/Network2.0/**/*.h"
    ss.source_files = "EMSpeed/Network2.0/**/*.{h,m}"
    ss.dependency     "EMSpeed/UIKit/Core"
    ss.dependency     "AFNetworking"
    ss.dependency     "PINCache"
    ss.dependency     "JSONModel"
  end

end
