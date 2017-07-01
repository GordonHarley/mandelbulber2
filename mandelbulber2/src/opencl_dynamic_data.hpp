/*
 * opencl_dynamic_data.hpp
 *
 *  Created on: 17 cze 2017
 *      Author: krzysztof
 */

#ifndef MANDELBULBER2_SRC_OPENCL_DYNAMIC_DATA_HPP_
#define MANDELBULBER2_SRC_OPENCL_DYNAMIC_DATA_HPP_

#ifdef USE_OPENCL

#include <QtCore>
#if defined(__APPLE__) || defined(__MACOSX)
#include <OpenCL/cl.hpp>
#else
#include <CL/cl.hpp>
#endif

class cMaterial;
struct sVectorsAround;
class cLights;

class cOpenClDynamicData
{
public:
	cOpenClDynamicData();
	~cOpenClDynamicData();

	void Clear();
	static int PutDummyToAlign(int dataLength, int alignmentSize, QByteArray *array);
	void BuildMaterialsData(const QMap<int, cMaterial> &materials);
	void BuildAOVectorsData(const sVectorsAround *AOVectors, int verctorsCount);
	void BuildLightsData(const cLights *lights);
	void ReserveHeader();
	void FillHeader();
	QByteArray &GetData(void);

private:
	QByteArray data;
	cl_int totalDataOffset;

	cl_int materialsOffset;
	int materialsOffsetAddress;

	cl_int AOVectorsOffset;
	int AOVectorsOffsetAddress;

	cl_int lightsOffset;
	int lightsOffsetAddress;
};

#endif // USE_OPENCL

#endif /* MANDELBULBER2_SRC_OPENCL_DYNAMIC_DATA_HPP_ */