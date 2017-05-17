/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Hybrid of Mandelbox and Mandelbulb power 2 with scaling of z axis
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
inline void BoxFoldBulbPow2Iteration(float3 *z, __constant sFractalCl *fractal)
{
	if (fabs(z->x) > fractal->foldingIntPow.foldFactor)
		z->x = copysign(fractal->foldingIntPow.foldFactor * 2.0f, z->x) - z->x;
	if (fabs(z->y) > fractal->foldingIntPow.foldFactor)
		z->y = copysign(fractal->foldingIntPow.foldFactor * 2.0f, z->y) - z->y;
	if (fabs(z->z) > fractal->foldingIntPow.foldFactor)
		z->z = copysign(fractal->foldingIntPow.foldFactor * 2.0f, z->z) - z->z;

	float fR2_2 = 1.0f;
	float mR2_2 = 0.25f;
	float r2_2 = dot(*z, *z);
	float tglad_factor1_2 = native_divide(fR2_2, mR2_2);

	if (r2_2 < mR2_2)
	{
		*z = *z * tglad_factor1_2;
	}
	else if (r2_2 < fR2_2)
	{
		float tglad_factor2_2 = native_divide(fR2_2, r2_2);
		*z = *z * tglad_factor2_2;
	}

	*z = *z * 2.0f;
	float x2 = z->x * z->x;
	float y2 = z->y * z->y;
	float z2 = z->z * z->z;
	float temp = 1.0f - native_divide(z2, (x2 + y2));
	float3 zTemp;
	zTemp.x = (x2 - y2) * temp;
	zTemp.y = 2.0f * z->x * z->y * temp;
	zTemp.z = -2.0f * z->z * native_sqrt(x2 + y2);
	*z = zTemp;
	z->z *= fractal->foldingIntPow.zFactor;

	// INFO remark: changed sequence of operation.
	// adding of C constant was before multiplying by z-factor
}
#else
inline void BoxFoldBulbPow2Iteration(double3 *z, __constant sFractalCl *fractal)
{
	if (fabs(z->x) > fractal->foldingIntPow.foldFactor)
		z->x = copysign(fractal->foldingIntPow.foldFactor, z->x) * 2.0 - z->x;
	if (fabs(z->y) > fractal->foldingIntPow.foldFactor)
		z->y = copysign(fractal->foldingIntPow.foldFactor, z->y) * 2.0 - z->y;
	if (fabs(z->z) > fractal->foldingIntPow.foldFactor)
		z->z = copysign(fractal->foldingIntPow.foldFactor, z->z) * 2.0 - z->z;

	double fR2_2 = 1.0;
	double mR2_2 = 0.25;
	double r2_2 = dot(*z, *z);
	double tglad_factor1_2 = native_divide(fR2_2, mR2_2);

	if (r2_2 < mR2_2)
	{
		*z = *z * tglad_factor1_2;
	}
	else if (r2_2 < fR2_2)
	{
		double tglad_factor2_2 = native_divide(fR2_2, r2_2);
		*z = *z * tglad_factor2_2;
	}

	*z = *z * 2.0;
	double x2 = z->x * z->x;
	double y2 = z->y * z->y;
	double z2 = z->z * z->z;
	double temp = 1.0 - native_divide(z2, (x2 + y2));
	double3 zTemp;
	zTemp.x = (x2 - y2) * temp;
	zTemp.y = 2.0 * z->x * z->y * temp;
	zTemp.z = -2.0 * z->z * native_sqrt(x2 + y2);
	*z = zTemp;
	z->z *= fractal->foldingIntPow.zFactor;

	// INFO remark: changed sequence of operation.
	// adding of C constant was before multiplying by z-factor
}
#endif
