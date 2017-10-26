{
  'targets': [{
    'target_name': 'audioMixer',
    'sources': [
      'addon.cc',
      'AudioMixerWrapper.cc',
      'AudioMixer.cpp',
      'AcmmFrameMixer.cpp',
      'AcmmParticipant.cpp',
      'AcmInput.cpp',
      'FfInput.cpp',
      'AcmOutput.cpp',
      'PcmOutput.cpp',
      'FfOutput.cpp',
      'AudioUtilities.cpp',
      '../../addons/common/NodeEventRegistry.cc',
      '../../../core/woogeen_base/MediaFramePipeline.cpp',
    ],
    'cflags_cc': [
        '-Wall',
        '-O$(OPTIMIZATION_LEVEL)',
        '-g',
        '-std=c++11',
        '-DWEBRTC_POSIX',
    ],
    'cflags_cc!': [
        '-fno-exceptions',
    ],
    'include_dirs': [ '$(CORE_HOME)/common',
                      '$(CORE_HOME)/erizo/src/erizo',
                      '$(CORE_HOME)/woogeen_base',
                      '$(CORE_HOME)/../../third_party/webrtc/src',
                      '$(CORE_HOME)/../../build/libdeps/build/include',
    ],
    'libraries': [
      '-L$(CORE_HOME)/../../third_party/webrtc', '-lwebrtc',
      '-lboost_thread',
      '-llog4cxx',
      '<!@(pkg-config --libs libavcodec)',
      '<!@(pkg-config --libs libavformat)',
      '<!@(pkg-config --libs libavutil)',
    ],
  }]
}
