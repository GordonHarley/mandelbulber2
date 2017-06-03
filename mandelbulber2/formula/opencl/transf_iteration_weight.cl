/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * iteration weight. Influence fractal based on the weight of
 * Z values after different iterations
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
float4 TransfIterationWeightIteration(float4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 zA = (aux->i == fractal->transformCommon.intA) ? z : (float4){};
	float4 zB = (aux->i == fractal->transformCommon.intB) ? z : (float4){};

	z = (z * fractal->transformCommon.scale) + (zA * fractal->transformCommon.offset)
			+ (zB * fractal->transformCommon.offset0);
	aux->DE *= fractal->transformCommon.scale;
	aux->r_dz *= fractal->transformCommon.scale;
	return z;
}
#else
double4 TransfIterationWeightIteration(
	double4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 zA = (aux->i == fractal->transformCommon.intA) ? z : (double4){};
	double4 zB = (aux->i == fractal->transformCommon.intB) ? z : (double4){};

	z = (z * fractal->transformCommon.scale) + (zA * fractal->transformCommon.offset)
			+ (zB * fractal->transformCommon.offset0);
	aux->DE *= fractal->transformCommon.scale;
	aux->r_dz *= fractal->transformCommon.scale;
	return z;
}
#endif