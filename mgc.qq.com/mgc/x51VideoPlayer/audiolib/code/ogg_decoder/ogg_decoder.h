#ifndef __OGG_DECODER_H__
#define __OGG_DECODER_H__

#include <vorbis/vorbisenc.h>

#define MAX_TRANS_BUFFER	5000

class COggDecoder
{
	vorbis_info m_vi;
	
	vorbis_dsp_state m_vd;
	vorbis_block m_vb;
	int m_sample_rate;
	int m_begin_samples;
	vorbis_comment m_vc;

public:
	COggDecoder();
	virtual ~COggDecoder();

public:  //公开接口
	void ReleaseDecoder();
	int InitDecoder(bool high_quality = false);
	void Ogg2Pcm(char* buf, int size, char* pcm_buf, int* pcm_buf_len);
};


#endif  //__OGG_DECODER_H__
