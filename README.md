## Description:
    This plugin is performs object detetion using edgetpu on jetson nano.
--------------------------------------------------------------------------------
Pre-requisites:
- GStreamer-1.0 Development package
- GStreamer-1.0 Base Plugins Development package
- OpenCV Development package
- Jetpack 4.4

Install using:
   sudo apt-get install libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
       libopencv-dev

--------------------------------------------------------------------------------
Compiling and installing the plugin:
Export or set in Makefile the appropriate cuda version using CUDA_VER
Run:
    make && sudo make install

--------------------------------------------------------------------------------
Usage:
    gst-launch-1.0 uridecodebin uri=<sample_video_path.mp4> ! \
    m.sink_0 nvstreammux name=m batch-size=1 width=1280 height=720 ! \
    coralinfer model-path="<sample_model_path.tflite>" \
    label-path="<sample_label_path.txt>" \
    threshold=0.6 ! nvvideoconvert ! nvdsosd ! nvvideoconvert ! \
    fpsdisplaysink name=fpssink text-overlay=true video-sink=xvimagesink sync=0

Example:
    gst-launch-1.0 uridecodebin uri=file:///home/stackfusion/pipline/sample_day.mp4 ! \
    m.sink_0 nvstreammux name=m batch-size=1 width=1280 height=720 ! \
    coralinfer model-path="/home/stackfusion/pipline/coral_plugin/gst-dsexample/resource/coco_ssd_mobilenet_v1_1.0_quant_2018_06_29_edgetpu.tflite" \
    label-path="/home/stackfusion/pipline/coral_plugin/gst-dsexample/resource/imagenet_labels.txt" \
    threshold=0.6 ! nvvideoconvert ! nvdsosd ! nvvideoconvert ! \
    fpsdisplaysink name=fpssink text-overlay=true video-sink=xvimagesink sync=0

 nvtracker tracker-width=640 tracker-height=352 ll-lib-file=/opt/nvidia/deepstream/deepstream-5.0/lib/libnvds_nvdcf.so ll-config-file=/home/stackfusion/pipline/coral_plugin/resource/tracker_config.yml    
 gst-launch-1.0 uridecodebin uri=file:///home/stackfusion/pipline/sample_day.mp4 ! m.sink_0 nvstreammux name=m batch-size=1 width=1280 height=720 ! coralinfer config-file-path="/home/stackfusion/pipline/coral_plugin/resource/sample_config.txt" ! nvvideoconvert ! nvtracker tracker-width=640 tracker-height=320 ll-lib-file=/opt/nvidia/deepstream/deepstream-5.0/lib/libnvds_mot_klt.so ll-config-file=/home/stackfusion/pipline/coral_plugin/resource/tracker_config_1.yml !  nvdsanalytics config-file=/home/stackfusion/pipline/coral_plugin/resource/config_nvdsanalytics.txt ! nvdsosd ! nvvideoconvert ! fpsdisplaysink name=fpssink text-overlay=true video-sink=xvimagesink sync=0

--------------------------------------------------------------------------------
Refrences:
    For Deepstream Plugin:
        https://docs.nvidia.com/metropolis/deepstream/dev-guide/index.html#page/DeepStream_Development_Guide/deepstream_custom_plugin.html
    
    For Google Coral integraion:
        Ref:
            https://www.tensorflow.org/lite/api_docs/cc # Tflite cpp docs
            https://coral.ai/docs/edgetpu/tflite-cpp/ # Run inference on edgetpu with TensorFlow Lite in C++
            https://github.com/google-coral/edgetpu/tree/master/src/cpp # for using tflite c++ api with edgetpu.
            https://github.com/iwatake2222/EdgeTPU_CPP # for knowing how to build tflite on aarch64
add debug info
Add confidence in debug
change forlder name
change resource folder location
name : algofcs_coralinfer
@todo: use example_optimized
Add exception for file handlers
make tensorflow submodule and document commit id.
add ds version
--------------------------------------------------------------------------------
Properties:
    model-path          : path of model used by edge-tpu
                        flags: readable, writable
                        String. Default: "/home/"
    label-path          : path of label used by edge-tpu
                        flags: readable, writable
                        String. Default: "/home/"
    threshold           : threshold of object to be detected by edge-tpu
                        flags: readable, writable
                        Float. Range: 0.0 - 1.0 Default: 0.7

--------------------------------------------------------------------------------
Corresponding config file changes (Add the following section). GPU ID might need
modification based on the GPU configuration:
