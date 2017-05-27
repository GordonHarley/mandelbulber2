/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * MsltoeSym3Mod based on the formula from Mandelbulb3D
 * @reference http://www.fractalforums.com/theory/choosing-the-squaring-formula-by-location/15/
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
void MsltoeSym3ModIteration(float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	float4 c = aux->const_c;
	aux->r = length(*z);
	aux->r_dz = aux->r_dz * 2.0f * aux->r;
	float4 temp = *z;
	if (fabs(z->y) < fabs(z->z)) // then swap
	{
		z->y = temp.z; // making z->y furthest away from axis
		z->z = temp.y;
	}
	if (z->y > z->z) // then change sign of z->x and z->z
	{
		z->x = -z->x;
		z->z = -z->z;
	}
	float4 z2 = *z * *z; // squares
	float v3 = mad(z2.z, fractal->transformCommon.scale0 * fractal->transformCommon.scale0 * z2.y,
		(z2.x + z2.y + z2.z));
	; // sum of squares
	// if (v3 < 1e-21f && v3 > -1e-21f) v3 = (v3 > 0) ? 1e-21f : -1e-21f;
	float zr = 1.0f - native_divide(z2.z, v3);
	temp.x = (z2.x - z2.y) * zr;
	temp.y = 2.0f * z->x * z->y * zr * fractal->transformCommon.scale; // scaling temp.y
	temp.z = 2.0f * z->z * native_sqrt(z2.x + z2.y);

	*z = temp + fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		float4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z->x += copysign(tempFAB.x, z->x);
		z->y += copysign(tempFAB.y, z->y);
		z->z += copysign(tempFAB.z, z->z);
	}
	float lengthTempZ = length(-*z);
	// if (lengthTempZ > -1e-21f) lengthTempZ = -1e-21f;   //  *z is neg.)
	*z *= 1.0f + native_divide(fractal->transformCommon.offset, lengthTempZ);
	*z *= fractal->transformCommon.scale1;
	aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale1), 1.0f);
	aux->r_dz *= fabs(fractal->transformCommon.scale1);

	if (fractal->transformCommon.functionEnabledFalse // quaternion fold
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		aux->r_dz = aux->r_dz * 2.0f * length(*z);
		*z = (float4){z->x * z->x - z->y * z->y - z->z * z->z, z->x * z->y, z->x * z->z, z->w};
		if (fractal->transformCommon.functionEnabledAxFalse)
		{
			aux->r = length(*z);
			float4 temp2 = *z;
			float tempL = length(temp2);
			*z *= (float4){1.0f, 2.0f, 2.0f, 1.0f};
			// if (tempL < 1e-21f) tempL = 1e-21f;
			float avgScale = native_divide(length(*z), tempL);
			// aux->r_dz *= avgScale * fractal->transformCommon.scaleA1;
			float tempAux = aux->r_dz * avgScale;
			aux->r_dz = mad(fractal->transformCommon.scaleA1, (tempAux - aux->r_dz), aux->r_dz);
		}
		else
		{
			*z *= (float4){1.0f, 2.0f, 2.0f, 1.0f};
		}
	}
}
#else
void MsltoeSym3ModIteration(double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	double4 c = aux->const_c;
	aux->r = length(*z);
	aux->r_dz = aux->r_dz * 2.0 * aux->r;
	double4 temp = *z;
	if (fabs(z->y) < fabs(z->z)) // then swap
	{
		z->y = temp.z; // making z->y furthest away from axis
		z->z = temp.y;
	}
	if (z->y > z->z) // then change sign of z->x and z->z
	{
		z->x = -z->x;
		z->z = -z->z;
	}
	double4 z2 = *z * *z; // squares
	double v3 = mad(z2.z, fractal->transformCommon.scale0 * fractal->transformCommon.scale0 * z2.y,
		(z2.x + z2.y + z2.z));
	; // sum of squares
	// if (v3 < 1e-21 && v3 > -1e-21) v3 = (v3 > 0) ? 1e-21 : -1e-21;
	double zr = 1.0 - native_divide(z2.z, v3);
	temp.x = (z2.x - z2.y) * zr;
	temp.y = 2.0 * z->x * z->y * zr * fractal->transformCommon.scale; // scaling temp.y
	temp.z = 2.0 * z->z * native_sqrt(z2.x + z2.y);

	*z = temp + fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		double4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z->x += copysign(tempFAB.x, z->x);
		z->y += copysign(tempFAB.y, z->y);
		z->z += copysign(tempFAB.z, z->z);
	}
	double lengthTempZ = length(-*z);
	// if (lengthTempZ > -1e-21) lengthTempZ = -1e-21;   //  *z is neg.)
	*z *= 1.0 + native_divide(fractal->transformCommon.offset, lengthTempZ);
	*z *= fractal->transformCommon.scale1;
	aux->DE = aux->DE * fabs(fractal->transformCommon.scale1) + 1.0;
	aux->r_dz *= fabs(fractal->transformCommon.scale1);

	if (fractal->transformCommon.functionEnabledFalse // quaternion fold
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		aux->r_dz = aux->r_dz * 2.0 * length(*z);
		*z = (double4){z->x * z->x - z->y * z->y - z->z * z->z, z->x * z->y, z->x * z->z, z->w};
		if (fractal->transformCommon.functionEnabledAxFalse)
		{
			aux->r = length(*z);
			double4 temp2 = *z;
			double tempL = length(temp2);
			*z *= (double4){1.0, 2.0, 2.0, 1.0};
			// if (tempL < 1e-21) tempL = 1e-21;
			double avgScale = native_divide(length(*z), tempL);
			// aux->r_dz *= avgScale * fractal->transformCommon.scaleA1;
			double tempAux = aux->r_dz * avgScale;
			aux->r_dz = mad(fractal->transformCommon.scaleA1, (tempAux - aux->r_dz), aux->r_dz);
		}
		else
		{
			*z *= (double4){1.0, 2.0, 2.0, 1.0};
		}
	}
}
#endif