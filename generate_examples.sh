#!/bin/bash

HERE=$PWD
SEGMENT_DURATION=10

clean() {
   rm -rf reckless_in_pyrmont/hls_*
}

gen_hls_ts_byterange() {
    INPUT=$PWD/${1}.mp4
    if [ ! -d hls_ts_byterange ]; then
      mkdir hls_ts_byterange
      cd hls_ts_byterange || exit
      ffmpeg -i $INPUT -c:v copy -c:a copy -f hls -hls_time $SEGMENT_DURATION -hls_flags single_file ${1}.m3u8
    fi
}

gen_hls_fmp4() {
    INPUT=$PWD/${1}.mp4
    if [ ! -d hls_fmp4 ]; then
      mkdir hls_fmp4
      cd hls_fmp4 || exit
      ffmpeg -i $INPUT -c:v copy -c:a copy -f hls -hls_time $SEGMENT_DURATION -hls_segment_type fmp4 ${1}.m3u8
    fi
}

gen_hls_fmp4_byterange() {
    INPUT=$PWD/${1}.mp4
    if [ ! -d hls_fmp4_byterange ]; then
      mkdir hls_fmp4_byterange
      cd hls_fmp4_byterange || exit
      ffmpeg -i $INPUT -c:v copy -c:a copy -f hls -hls_time $SEGMENT_DURATION -hls_flags single_file -hls_segment_type fmp4 ${1}.m3u8
    fi
}

gen_hls_examples() {
    gen_hls_ts_byterange ${1} &
    gen_hls_fmp4_byterange ${1} &
    gen_hls_fmp4 ${1} &
}

gen_example() {
    mkdir -p ${1}
    cd ${1} && gen_hls_examples ${1}
}

clean
gen_example reckless_in_pyrmont

}