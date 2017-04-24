
#include "ogg_decoder.h"
#include "AS3/AS3.h"
#include <stdio.h>

// return: video engine handle
__attribute__((annotate("as3sig:public function CreateCppOggDecoder(high_quality:Boolean):uint")))
void CreateCppOggDecoder() {
	COggDecoder* ogg_decoder = new COggDecoder;
	unsigned int ret = ogg_decoder->InitDecoder(high_quality);
	unsigned int h = 0;
	if (ret == 0)
		h = (unsigned int)ogg_decoder;
	else
		h = ret;
	{
	AS3_DeclareVar(asresult, uint);
	AS3_CopyScalarToVar(asresult, h);
	}
	{
	AS3_ReturnAS3Var(asresult);
	}
}

// arg1: video engine handle
__attribute__((annotate("as3sig:public function DestroyCppOggDecoder(decoder:uint):void")))
void DestroyCppOggDecoder() {
	unsigned int h = 0;
	{
	AS3_GetScalarFromVar(h, decoder);
	}
	
	COggDecoder* ogg_decoder = (COggDecoder*)h;
	ogg_decoder->ReleaseDecoder();
	delete ogg_decoder;
}

// arg1: this_engine
__attribute__((annotate("as3sig:public function Ogg2Pcm(decoder:uint, ogg_buff:uint, ogg_buff_len:uint, pcm_buff:uint):int")))
void Ogg2Pcm() {
	unsigned int h = 0;
	{
	AS3_GetScalarFromVar(h, decoder);
	}
	COggDecoder* ptr = (COggDecoder*)h;
	
	char* ogg = (char*)0;
	int	ogg_len = 0;
	char* pcm = (char*)0;
	int pcm_len = 0;
	{
	AS3_GetScalarFromVar(ogg, ogg_buff);
	}
	{
	AS3_GetScalarFromVar(ogg_len, ogg_buff_len);
	}
	{
	AS3_GetScalarFromVar(pcm, pcm_buff);
	}
	
	printf("ogg len11111111111111111111111111111111111 %d", ogg_len);
	int buffer_pos = 0;
	int pcm_pos = 0;
	int len = 0;
	int i = 3;
	while (buffer_pos < ogg_len)
	{
		len = *((int*)(&ogg[buffer_pos]));// + ogg[buffer_pos] << 8 + ogg[buffer_pos] << 16 + ogg[buffer_pos] << 24;
		ptr->Ogg2Pcm(&ogg[buffer_pos], len, &pcm[pcm_pos], &pcm_len);
		pcm_pos += pcm_len;
		buffer_pos += len;
	}
	
	{
	AS3_DeclareVar(asresult, int);
	AS3_CopyScalarToVar(asresult, pcm_pos);
	}
	{
	AS3_ReturnAS3Var(asresult);
	}
}