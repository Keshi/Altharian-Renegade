/** @file
   =============================================
   PENTAGRAMS & SUMMONING CIRCLES          v1.45
   =============================================
   gaoneng                      January 17, 2005
   #include "inc_draw"

   last updated on August 8, 2005

   modified by Ornedan of PRC to add new parameters:
    fDirectionXZ and fDirectionYZ

   Draw geometric forms using a variety of media
   =============================================
*/

#include "inc_draw_tools"

/*
   =============================================
   DRAW* PLACE* AND BEAM* FUNCTIONS DECLARATIONS
   =============================================
*/
// Draws a circle around lCenter
// =============================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius of circle in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the circle lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the circle.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawCircle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a spiral around lCenter
// =============================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spiral lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a spring around lCenter
// =============================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a line towards lCenter
// ============================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fLength = length of line in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of line respective to normal.           DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fTime = time in seconds taken to draw the line.                DEFAULT : 6.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawLineToCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, int nFrequency=90, float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a line from lCenter
// =========================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fLength = length of line in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of line respective to normal.           DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fTime = time in seconds taken to draw the line.                DEFAULT : 6.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawLineFromCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, int nFrequency=90, float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a polygonal spring around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawPolygonalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a polygonal spiral around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spiral lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawPolygonalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a polygon around lCenter
// ==============================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius of polygon in meters. (1 tile = 10.0m X 10.0m)
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the polygon lasts before fading.        DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the polygon.             DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawPolygon(int nDurationType, int nVFX, location lCenter, float fRadius, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a pentacle (five-pointed star) around lCenter
// ===================================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius of pentacle in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the pentacle lasts before fading.       DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the pentacle.            DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawPentacle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a pentaclic spiral around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the pentacle lasts before fading.       DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawPentaclicSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a pentaclic spring around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the pentacle lasts before fading.       DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawPentaclicSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a star spring around lCenter
// ==================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of spring in meters.
// fRadiusStartInner = starting inner radius of spring in meters.
// fRadiusEndOuter = ending outer radius of spring in meters.     DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of spring in meters.     DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nSides = number of sides (or points)                             DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the pentacle lasts before fading.       DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawStarSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a star spiral around lCenter
// ==================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of spiral in meters.
// fRadiusStartInner = starting inner radius of spiral in meters.
// fRadiusEndOuter = ending outer radius of spring in meters.     DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of spring in meters.     DEFAULT : 0.0
// nSides = number of sides (or points)                             DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the pentacle lasts before fading.       DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawStarSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a star around lCenter
// ===========================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusOuter = outer radius of star in meters. (1 tile = 10.0m X 10.0m)
// fRadiusInner = inner radius of star in meters.
// nSides = number of sides (or points)                             DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the pentacle lasts before fading.       DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawStar(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a hemisphere around lCenter
// =================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of sphere in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of sphere in meters.                DEFAULT : 0.0
// fHeightStart = starting height of sphere in meters.            DEFAULT : 0.0
// fHeightEnd = ending height of sphere in meters.                DEFAULT : 5.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the sphere lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the sphere.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the central/normal axis.             DEFAULT : "z"
void DrawHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a perfect sphere around lCenter
// =====================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius of sphere in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the sphere lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the sphere.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the central/normal axis.             DEFAULT : "z"
void DrawSphere(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a polygonal hemisphere around lCenter
// ===========================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of sphere in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of sphere in meters.                DEFAULT : 0.0
// fHeightStart = starting height of sphere in meters.            DEFAULT : 0.0
// fHeightEnd = ending height of sphere in meters.                DEFAULT : 5.0
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the sphere lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the sphere.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the central/normal axis.             DEFAULT : "z"
void DrawPolygonalHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a toroidal spring around lCenter
// ======================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the torus in meters.
// fRadiusStartInner = starting inner radius of the torus in meters.
// fRadiusEndOuter = ending outer radius of the torus in meters.  DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the torus in meters.  DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fLoopsPerRev = number of loops per revolution.                DEFAULT : 36.0
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawToroidalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fLoopsPerRev=36.0f, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a toroidal spiral around lCenter
// ======================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the torus in meters.
// fRadiusStartInner = starting inner radius of the torus in meters.
// fRadiusEndOuter = ending outer radius of the torus in meters.  DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the torus in meters.  DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fLoopsPerRev = number of loops per revolution.                DEFAULT : 36.0
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawToroidalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fDuration=0.0f, int nFrequency=90, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a standard torus around lCenter
// =====================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusOuter = outer radius of the torus in meters.
// fRadiusInner = inner radius of the torus in meters.
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fLoopsPerRev = number of loops per revolution.                DEFAULT : 36.0
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the torus.               DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawTorus(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, float fDuration=0.0f, int nFrequency=90, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a sinusoidal curve from lCenter
// =====================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = amplitude of curve in meters.
// fLength = horizontal length of curve in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of line respective to normal.           DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the torus.               DEFAULT : 6.0
// fRotate = the shift in phase in degrees.                       DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawSinusoid(int nDurationType, int nVFX, location lCenter, float fRadius, float fLength, float fDirection=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws an elliptical spring around lCenter
// =========================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the ellipse in meters.
// fRadiusStartInner = starting inner radius of the ellipse in meters.
// fRadiusEndOuter = ending outer radius of the ellipse in meters.DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the ellipse in meters.DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the VFX lasts before fading.            DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawEllipticalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws an elliptical spiral around lCenter
// =========================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the ellipse in meters.
// fRadiusStartInner = starting inner radius of the ellipse in meters.
// fRadiusEndOuter = ending outer radius of the ellipse in meters.DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the ellipse in meters.DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the VFX lasts before fading.            DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawEllipticalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws an ellipse around lCenter
// ===============================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadiusOuter = outer radius of the ellipse in meters.
// fRadiusInner = inner radius of the ellipse in meters.
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the VFX lasts before fading.            DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the ellipse.             DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawEllipse(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a rhodonea helix around lCenter
// =====================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawRhodoneaSpring(int nDurationType, int nVFX, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a rhodonea around lCenter
// ===============================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawRhodonea(int nDurationType, int nVFX, location lCenter, float fRadius, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a hypocycloid helix around lCenter
// ========================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawHypocycloidSpring(int nDurationType, int nVFX, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a hypocycloid around lCenter
// ==================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawHypocycloid(int nDurationType, int nVFX, location lCenter, float fRadius, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a epicycloid helix around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawEpicycloidSpring(int nDurationType, int nVFX, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Draws a epicycloid around lCenter
// =================================
// nDurationType = DURATION_TYPE_* constant
// nVFX = the VFX_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the spring lasts before fading.         DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more effects are
//              generated and the closer they are to each other.   DEFAULT : 90
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
void DrawEpicycloid(int nDurationType, int nVFX, location lCenter, float fRadius, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f);

// Places a circle around lCenter
// ==============================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius of circle in meters. (1 tile = 10.0m X 10.0m)
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the circle.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceCircle(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a spiral around lCenter
// ==============================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceSpiral(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a spring around lCenter
// ==============================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a line towards lCenter
// =============================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fLength = length of line in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of line respective to normal.           DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fTime = time in seconds taken to draw the line.               DEFAULT : 12.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceLineToCenter(string sTemplate, location lCenter, float fLength, float fDirection=0.0f, int nFrequency=60, float fTime=12.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a line from lCenter
// ==========================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fLength = length of line in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of line respective to normal.           DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fTime = time in seconds taken to draw the line.               DEFAULT : 12.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceLineFromCenter(string sTemplate, location lCenter, float fLength, float fDirection=0.0f, int nFrequency=60, float fTime=12.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a polygonal spring around lCenter
// ========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlacePolygonalSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a polygonal spiral around lCenter
// ========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlacePolygonalSpiral(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nSides=3, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a polygon around lCenter
// ===============================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius of polygon in meters. (1 tile = 10.0m X 10.0m)
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// nFrequency = number of points, the higher the frequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the polygon.            DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlacePolygon(string sTemplate, location lCenter, float fRadius, int nSides=3, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a pentacle (five-pointed star) around lCenter
// ====================================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius of pentacle in meters. (1 tile = 10.0m X 10.0m)
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the pentacle.           DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlacePentacle(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a pentaclic spiral around lCenter
// ========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlacePentaclicSpiral(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a pentaclic spring around lCenter
// ========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlacePentaclicSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a star spring around lCenter
// ===================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of spring in meters.
// fRadiusStartInner = starting inner radius of spring in meters.
// fRadiusEndOuter = ending outer radius of spring in meters.     DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of spring in meters.     DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nSides = number of sides (or points)                             DEFAULT : 3
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceStarSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a star spiral around lCenter
// ===================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of spiral in meters.
// fRadiusStartInner = starting inner radius of spiral in meters.
// fRadiusEndOuter = ending outer radius of spring in meters.     DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of spring in meters.     DEFAULT : 0.0
// nSides = number of sides (or points)                             DEFAULT : 3
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceStarSpiral(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a star around lCenter
// ============================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusOuter = outer radius of star in meters. (1 tile = 10.0m X 10.0m)
// fRadiusInner = inner radius of star in meters.
// nSides = number of sides (or points)                             DEFAULT : 3
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceStar(string sTemplate, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a hemisphere around lCenter
// ==================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of sphere in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of sphere in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the sphere in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the sphere in meters.            DEFAULT : 5.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the sphere.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the central/normal axis.             DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a perfect sphere around lCenter
// ======================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius of sphere in meters. (1 tile = 10.0m X 10.0m)
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the sphere.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the central/normal axis.             DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceSphere(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a polygonal hemisphere around lCenter
// ============================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of sphere in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of sphere in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the sphere in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the sphere in meters.            DEFAULT : 5.0
// nSides = number of sides. nSides < 3 will default to 3.          DEFAULT : 3
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the sphere.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the central/normal axis.             DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlacePolygonalHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a toroidal spring around lCenter
// =======================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the torus in meters.
// fRadiusStartInner = starting inner radius of the torus in meters.
// fRadiusEndOuter = ending outer radius of the torus in meters.  DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the torus in meters.  DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fLoopsPerRev = number of loops per revolution.                DEFAULT : 36.0
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceToroidalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a toroidal spiral around lCenter
// =======================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the torus in meters.
// fRadiusStartInner = starting inner radius of the torus in meters.
// fRadiusEndOuter = ending outer radius of the torus in meters.  DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the torus in meters.  DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fLoopsPerRev = number of loops per revolution.                DEFAULT : 36.0
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceToroidalSpiral(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a standard torus around lCenter
// ======================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusOuter = outer radius of the torus in meters.
// fRadiusInner = inner radius of the torus in meters.
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fLoopsPerRev = number of loops per revolution.                DEFAULT : 36.0
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the torus.              DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceTorus(string sTemplate, location lCenter, float fRadiusOuter, float fRadiusInner, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a sinusoidal curve from lCenter
// ======================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = amplitude of curve in meters.
// fLength = horizontal length of curve in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of curve respective to normal.          DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the torus.              DEFAULT : 12.0
// fRotate = the shift in phase in degrees.                       DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceSinusoid(string sTemplate, location lCenter, float fRadius, float fLength, float fDirection=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places an elliptical spring around lCenter
// ==========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the ellipse in meters.
// fRadiusStartInner = starting inner radius of the ellipse in meters.
// fRadiusEndOuter = ending outer radius of the ellipse in meters.DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the ellipse in meters.DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceEllipticalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places an elliptical spiral around lCenter
// ==========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of the ellipse in meters.
// fRadiusStartInner = starting inner radius of the ellipse in meters.
// fRadiusEndOuter = ending outer radius of the ellipse in meters.DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of the ellipse in meters.DEFAULT : 0.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceEllipticalSpiral(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places an ellipse around lCenter
// ================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadiusOuter = outer radius of the ellipse in meters.
// fRadiusInner = inner radius of the ellipse in meters.
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the ellipse.            DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceEllipse(string sTemplate, location lCenter, float fRadiusOuter, float fRadiusInner, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a stella octangula above lCenter
// =======================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fTime = time in seconds taken to draw the polyhedron.         DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceStellaOctangula(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a regular icosahedron above lCenter
// ==========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fTime = time in seconds taken to draw the polyhedron.         DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceIcosahedron(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a rhodonea helix around lCenter
// ======================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceRhodoneaSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a rhodonea around lCenter
// ================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceRhodonea(string sTemplate, location lCenter, float fRadius, float fRoulette=3.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a hypocycloid helix around lCenter
// =========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceHypocycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a hypocycloid around lCenter
// ===================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceHypocycloid(string sTemplate, location lCenter, float fRadius, float fRoulette=3.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a epicycloid helix around lCenter
// ========================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceEpicycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Places a epicycloid around lCenter
// ==================================
// sTemplate = blueprint resref of placeable to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fRoulette = arbitrary constant, affects number of petals.      DEFAULT : 3.0
// nFrequency = number of points, the higher nFrequency, the more placeables
//              are created and the closer they are to each other. DEFAULT : 60
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spring.             DEFAULT : 12.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType = DURATION_TYPE_* constant if an additional visual effect is
//                 to be applied. Default invalid duration.        DEFAULT : -1
// nVFX = the VFX_* constant to use if an additional visual effect is to be
//        applied to the placeables. Default invalid effect.       DEFAULT : -1
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the effect lasts before fading.         DEFAULT : 0.0
// fWait = time in seconds to wait before applying visual effect. DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeables get destroyed.                          DEFAULT : 0.0
void PlaceEpicycloid(string sTemplate, location lCenter, float fRadius, float fRoulette=3.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f);

// Beams a polygonal hemisphere around lCenter
// ===========================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of sphere in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of sphere in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the sphere in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the sphere in meters.            DEFAULT : 5.0
// nSides = number of sides.                                        DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the sphere.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the central/normal axis.             DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamPolygonalHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a polygonal spring around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nSides = number of sides.                                        DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamPolygonalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a polygonal spiral around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// nSides = number of sides.                                        DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.             DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamPolygonalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a polygon around lCenter
// ==============================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius of polygon in meters. (1 tile = 10.0m X 10.0m)
// nSides = number of sides.                                        DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the polygon.             DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamPolygon(int nDurationType, int nVFX, location lCenter, float fRadius, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a star around lCenter
// ===========================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusOuter = outer radius of star in meters. (1 tile = 10.0m X 10.0m)
// fRadiusInner = inner radius of star in meters.
// nSides = number of sides (or points)                             DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the pentacle.            DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamStar(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a star spring around lCenter
// ==================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of spring in meters.
// fRadiusStartInner = starting inner radius of spring in meters.
// fRadiusEndOuter = ending outer radius of spring in meters.     DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of spring in meters.     DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// nSides = number of sides (or points)                             DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the pentacle.            DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamStarSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a star spiral around lCenter
// ==================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStartOuter = starting outer radius of spring in meters.
// fRadiusStartInner = starting inner radius of spring in meters.
// fRadiusEndOuter = ending outer radius of spiral in meters.     DEFAULT : 0.0
// fRadiusEndInner = ending inner radius of spiral in meters.     DEFAULT : 0.0
// nSides = number of sides (or points)                             DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the pentacle.            DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamStarSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a pentacle around lCenter
// ===============================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius of pentacle in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the pentacle.            DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamPentacle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a pentaclic spiral around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spiral in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spiral in meters.                DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 1.0
// fTime = time in seconds taken to draw the spiral.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamPentaclicSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a pentaclic spring around lCenter
// =======================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of spring in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of spring in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the spring in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the spring in meters.            DEFAULT : 5.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fRev = number of revolutions.                                  DEFAULT : 5.0
// fTime = time in seconds taken to draw the spring.              DEFAULT : 6.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamPentaclicSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a line from lCenter
// =========================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fLength = length of line in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of line respective to normal.           DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beam lasts before fading.           DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use..              DEFAULT : ""
// fTime = time in seconds taken to draw the line.                DEFAULT : 6.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamLineFromCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a line to lCenter
// =======================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fLength = length of line in meters. (1 tile = 10.0m X 10.0m)
// fDirection = direction of line respective to normal.           DEFAULT : 0.0
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beam lasts before fading.           DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to draw the line.                DEFAULT : 6.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamLineToCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a stella octangula above lCenter
// ======================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to create the placeable nodes.   DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamStellaOctangula(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a regular icosahedron above lCenter
// =========================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to create the placeable nodes.   DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamIcosahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a regular dodecahedron above lCenter
// =========================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to create the placeable nodes.   DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamDodecahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a rhombic triacontahedron above lCenter
// =============================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to create the placeable nodes.   DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamTriacontahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a cuboctahedron above lCenter
// =============================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to create the placeable nodes.   DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamCuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a small rhombicuboctahedron above lCenter
// =============================================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadius = radius in meters. (1 tile = 10.0m X 10.0m)
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to create the placeable nodes.   DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamSmallRhombicuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

// Beams a gengon above lCenter
// ============================
// nDurationType = DURATION_TYPE_* constant.
// nVFX = the VFX_BEAM_* constant to use.
// lCenter = the location of the center.
// fRadiusStart = starting radius of gengon in meters. (1 tile = 10.0m X 10.0m)
// fRadiusEnd = ending radius of gengon in meters.                DEFAULT : 0.0
// fHeightStart = starting height of the gengon in meters.        DEFAULT : 0.0
// fHeightEnd = ending height of the gengon in meters.            DEFAULT : 5.0
// nSides = number of sides.                                        DEFAULT : 3
// fDuration = if nDurationType is DURATION_TYPE_TEMPORARY, this is the number
//             of seconds the beams lasts before fading.          DEFAULT : 0.0
// sTemplate = blueprint resref of placeable to use.               DEFAULT : ""
// fTime = time in seconds taken to draw the gengon.              DEFAULT : 6.0
// fWait = time in seconds to wait before applying the beams.     DEFAULT : 1.0
// fRotate = the angle of rotation respective to normal.          DEFAULT : 0.0
// fTwist = rotational displacement of end polygon in degrees.    DEFAULT : 0.0
// sAxis = ("x", "y" or "z") the normal axis.                     DEFAULT : "z"
// nDurationType2 = DURATION_TYPE_* constant if an additional visual effect is
//                  to be applied. Default invalid duration.       DEFAULT : -1
// nVFX2 = the VFX_* constant to use if an additional visual effect is to be
//         applied to the placeable nodes. Default invalid effect. DEFAULT : -1
// fDuration2 = if nDurationType2 is DURATION_TYPE_TEMPORARY, this is the number
//              of seconds the effect lasts before fading.        DEFAULT : 0.0
// fWait2 = time in seconds to wait before applying nVFX2.        DEFAULT : 1.0
// fLifetime = if fLifetime is not 0.0, then this is time in seconds before the
//             placeable nodes get destroyed.                     DEFAULT : 0.0
void BeamGengon(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, float fTwist=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f);

/*
   =============================================
   OBJECT-RETURNING FUNCTIONS DECLARATIONS
   =============================================
*/
// Object-returning equivalent of the void-returning functions
// sTag = tag of oData (the data storage invisible object)

object ObjectPlaceSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_SPRING");
object ObjectPlacePolygonalSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_POLYGONALSPRING");
object ObjectPlacePentaclicSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_PENTACLICSPRING");
object ObjectPlaceStarSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_STARSPRING");
object ObjectPlaceHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_HEMISPHERE");
object ObjectPlacePolygonalHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_POLYGONALHEMISPHERE");
object ObjectPlaceSinusoid(string sTemplate, location lCenter, float fRadius, float fLength, float fDirection=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_SINUSOID");
object ObjectPlaceToroidalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_TOROIDALSPRING");
object ObjectPlaceEllipticalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_ELLIPTICALSPRING");
object ObjectPlaceStellaOctangula(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_STELLAOCTANGULA");
object ObjectPlaceIcosahedron(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_ICOSAHEDRON");
object ObjectPlaceRhodoneaSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_RHODONEASPRING");
object ObjectPlaceHypocycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_HYPOCYCLOIDSPRING");
object ObjectPlaceEpicycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_EPICYCLOIDSPRING");
object ObjectBeamPolygonalHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_POLYGONALHEMISPHERE");
object ObjectBeamPolygonalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_POLYGONALSPRING");
object ObjectBeamPolygon(int nDurationType, int nVFX, location lCenter, float fRadius, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_POLYGON");
object ObjectBeamStar(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_STAR");
object ObjectBeamStarSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_STARSPRING");
object ObjectBeamPentacle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_PENTACLE");
object ObjectBeamPentaclicSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_PENTACLICSPRING");
object ObjectBeamLineFromCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_LINEFROM");
object ObjectBeamLineToCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_LINETO");
object ObjectBeamStellaOctangula(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_STELLAOCTANGULA");
object ObjectBeamIcosahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_ICOSAHEDRON");
object ObjectBeamDodecahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_DODECAHEDRON");
object ObjectBeamTriacontahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_TRIACONTAHEDRON");
object ObjectBeamCuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_CUBOCTAHEDRON");
object ObjectBeamSmallRhombicuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_SMALLRHOMBICUBOCTAHEDRON");
object ObjectBeamGengon(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, float fTwist=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_GENGON");

/*
   =============================================
   PRIVATE FUNCTIONS DECLARATIONS
   =============================================
*/
// Draws a straight line from vOne to vTwo
// void DrawLineFromVectorToVector(int nDurationType, int nVFX, object oArea, vector vOne, vector vTwo, float fDuration, int nFrequency, float fTime);

// Places a straight line from vOne to vTwo, automatically applies VFX if any
// void PlaceLineFromVectorToVector(string sTemplate, object oArea, vector vOne, vector vTwo, int nFrequency, float fTime, int nDurationType, int nVFX, float fDuration, float fWait, float fLifetime, object oData);

// Delayable CreateObject, automatically applies VFX if any, and sets created object as oData's local object using auto-generated number if fLifetime > 0.0
// void gao_ActionCreateObject(string sTemplate, location lLocation, int nDurationType, int nVFX, float fDuration, float fWait, float fLifetime, object oData);

// Delayable CreateObject, automatically sets created object as oData's local object and applies VFX if any
// void gao_ActionCreateLocalObject(string sTemplate, location lLocation, string sNumber, object oData, int nDurationType, int nVFX, float fDuration, float fWait, float fLifetime);

// Apply EffectBeam between two of oData's local objects
// void gao_ActionApplyLocalBeamEffect(object oData, string sNumber1, string sNumber2, int nDurationType, int nVFX, float fDuration);

// Return properly rotated vector
//vector gao_RotateVector(vector vCenter, string sAxis, float x, float y, float z, float fRotateXZ, float fRotateYZ);

/*
   =============================================
   FUNCTIONS IMPLEMENTATIONS
   =============================================
*/

/*
   =============================================
   PRIVATE FUNCTIONS
   =============================================
*/

void gao_ActionCreateObject(string sTemplate, location lLocation, int nDurationType, int nVFX, float fDuration, float fWait, float fLifetime, object oData)
{
    object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sTemplate, lLocation);
    if (nDurationType >= 0 && nVFX >= 0) DelayCommand(fWait, ApplyEffectToObject(nDurationType, EffectVisualEffect(nVFX), oPlaceable, fDuration));
    if (fLifetime > 0.0) DestroyObject(oPlaceable, fLifetime);
    else    // if display is permanent, then start storing the objects as local to ease garbage collection later on.
    {       // code modified from Ornedan's modification of the original function
        int i = GetLocalInt(oData, "storetotal");
        AssignCommand(oPlaceable, ActionDoCommand(SetLocalObject(oData, "store" + IntToString(i), oPlaceable)));
        SetLocalInt(oData, "storetotal", i+1);
    }
}

void gao_ActionCreateLocalObject(string sTemplate, location lLocation, string sNumber, object oData, int nDurationType, int nVFX, float fDuration, float fWait, float fLifetime)
{
    object oObject = CreateObject(OBJECT_TYPE_PLACEABLE, sTemplate, lLocation);
    AssignCommand(oObject, ActionDoCommand(SetLocalObject(oData, sNumber, oObject)));
    if (nDurationType >= 0 && nVFX >= 0) DelayCommand(fWait, ApplyEffectToObject(nDurationType, EffectVisualEffect(nVFX), oObject, fDuration));
    if (fLifetime > 0.0) DestroyObject(oObject, fLifetime);
}

void gao_ActionApplyLocalBeamEffect(object oData, string sNumber1, string sNumber2, int nDurationType, int nVFX, float fDuration)
{
    object oNode1 = GetLocalObject(oData, sNumber1);
    object oNode2 = GetLocalObject(oData, sNumber2);
    ApplyEffectToObject(nDurationType, EffectBeam(nVFX, oNode1, BODY_NODE_CHEST), oNode2, fDuration);
}

void DrawLineFromVectorToVector(int nDurationType, int nVFX, object oArea, vector vOne, vector vTwo, float fDuration, int nFrequency, float fTime)
{
    int i;
    if (nFrequency < 1) nFrequency = 1;
    vector vResultant = vTwo - vOne;
    vector vUnit = VectorNormalize(vResultant);
    float fDelay = fTime/IntToFloat(nFrequency);
    float fLength = VectorMagnitude(vResultant);
    float fDelta = fLength/IntToFloat(nFrequency); // distance between each node
    float fAngle = VectorToAngle(vUnit);
    location lPos;
    float f;
    for (i=0; i<nFrequency; i++)
    {
        f = IntToFloat(i);
        lPos = Location(oArea, vOne + fDelta*f*vUnit, fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

void PlaceLineFromVectorToVector(string sTemplate, object oArea, vector vOne, vector vTwo, int nFrequency, float fTime, int nDurationType, int nVFX, float fDuration, float fWait, float fLifetime, object oData)
{
    int i;
    if (nFrequency < 1) nFrequency = 1;
    vector vResultant = vTwo - vOne;
    vector vUnit = VectorNormalize(vResultant);
    float fDelay = fTime/IntToFloat(nFrequency);
    float fLength = VectorMagnitude(vResultant);
    float fTheta = fLength/IntToFloat(nFrequency); // distance between each node
    float fAngle = VectorToAngle(vUnit);
    location lPos;
    float f;

    for (i=0; i<nFrequency; i++)
    {
        f = IntToFloat(i);
        lPos = Location(oArea, vOne + fTheta*f*vUnit, fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }
}

vector gao_RotateVector(vector vCenter, string sAxis, float x, float y, float z, float fRotateXZ, float fRotateYZ)
{
    // Avoiding these if unnecessary should lower the CPU usage per call a fair bit. Not that it seems to be noticeable, but eh :P
    if(fRotateXZ != 0.0f)
    {
        // Determine the length of the vector
        float fLength = sqrt((x * x) + (z * z));
        // Determine the angle of the vector relative to the Z axle
        float fAngle  = acos(z / fLength);
        // Adjust for arcuscosine ambiquity
        if(x < 0.0f) fAngle = 360.0f - fAngle;

        // Add in the new angle to rotate by and calculate new coordinates
        fAngle += fRotateXZ;
        x = fLength * sin(fAngle);
        z = fLength * cos(fAngle);
    }
    if(fRotateYZ != 0.0f)
    {
        // Determine the length of the vector
        float fLength = sqrt((y * y) + (z * z));
        // Determine the angle of the vector relative to the Z axle
        float fAngle  = acos(z / fLength);
        // Adjust for arcuscosine ambiquity
        if(y < 0.0f) fAngle = 360.0f - fAngle;

        // Add in the new angle to rotate by and calculate new coordinates
        fAngle += fRotateYZ;
        y = fLength * sin(fAngle);
        z = fLength * cos(fAngle);
    }

    // Determine the final vector
    vector vPos;
    if (sAxis == "x") vPos = Vector(y, z, x) ;
    else if (sAxis == "y") vPos = Vector(z, x, y) ;
    else vPos = Vector(x, y, z) ;
    return vPos + vCenter ;
}

/*
   =============================================
   DRAW* FUNCTIONS
   =============================================
*/

void DrawEllipticalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    fRadiusStartOuter = (fRadiusStartOuter == 0.0) ? 0.01 : (fRadiusStartOuter < 0.0) ? -fRadiusStartOuter : fRadiusStartOuter ;
    fRadiusStartInner = (fRadiusStartInner == 0.0) ? 0.01 : (fRadiusStartInner < 0.0) ? -fRadiusStartInner : fRadiusStartInner ;
    fRadiusEndOuter = (fRadiusEndOuter == 0.0) ? 0.01 : (fRadiusEndOuter < 0.0) ? -fRadiusEndOuter : fRadiusEndOuter ;
    fRadiusEndInner = (fRadiusEndInner == 0.0) ? 0.01 : (fRadiusEndInner < 0.0) ? -fRadiusEndInner : fRadiusEndInner ;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fInnerDecay = (fRadiusStartInner - fRadiusEndInner)/IntToFloat(nFrequency); // change in radius per node
    float fOuterDecay = (fRadiusStartOuter - fRadiusEndOuter)/IntToFloat(nFrequency); // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos;
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fElliRadius, fElliAngle, fRadiusOuter, fEccentric;
    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fElliAngle = fTheta*f;
        fAngle = fElliAngle + fRotate;
        fRadiusOuter = fRadiusStartOuter - fOuterDecay*f;
        fEccentric = 1 - (pow(fRadiusStartInner - fInnerDecay*f, 2.0)/pow(fRadiusOuter, 2.0));
        fElliRadius =  fRadiusOuter*sqrt((1 - fEccentric)/(1 - fEccentric*pow(cos(fElliAngle), 2.0)));
        vPos = gao_RotateVector(vCenter, sAxis, fElliRadius*cos(fAngle), fElliRadius*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
        lPos = Location(oArea, vPos, fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

void DrawEllipticalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawEllipticalSpring(nDurationType, nVFX, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, 0.0, 0.0, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawEllipse(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawEllipticalSpring(nDurationType, nVFX, lCenter, fRadiusOuter, fRadiusInner, fRadiusOuter, fRadiusInner, 0.0, 0.0, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fDecay = (fRadiusStart - fRadiusEnd)/IntToFloat(nFrequency); // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos;
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle;
    for (i=0; i<nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        vPos = gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*f)*cos(fAngle), (fRadiusStart - fDecay*f)*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
        lPos = Location(oArea, vPos, fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

void DrawSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawSpring(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawCircle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawSpring(nDurationType, nVFX, lCenter, fRadius, fRadius, 0.0, 0.0, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawLineToCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, int nFrequency=90, float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawSpring(nDurationType, nVFX, lCenter, fLength, 0.0, 0.0, 0.0, fDuration, nFrequency, 0.0, fTime, fDirection, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawLineFromCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, int nFrequency=90, float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawSpring(nDurationType, nVFX, lCenter, 0.0, fLength, 0.0, 0.0, fDuration, nFrequency, 0.0, fTime, fDirection, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawPolygonalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=5, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nSides < 3) nSides = 3;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    if (fRev == 0.0) fRev = 5.0;
    float fEta = (fRev > 0.0) ? 360.0/IntToFloat(nSides) : -360.0/IntToFloat(nSides); // angle of segment
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides) : -fRev*IntToFloat(nSides); // total number of sides to draw including revolutions as float value
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions as int value
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDecay = (fRadiusStart - fRadiusEnd)/fSidesToDraw; // change in radius per side
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per side
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2;
    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fEta*f + fRotate;
        fAngle2 = fEta*g + fRotate;
        vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*f)*cos(fAngle1), (fRadiusStart - fDecay*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*g)*cos(fAngle2), (fRadiusStart - fDecay*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        DelayCommand(f*fDelayPerSide, DrawLineFromVectorToVector(nDurationType, nVFX, oArea, vPos1, vPos2, fDuration, nFrequencyPerSide, fDelayPerSide));
    }
}

void DrawPolygonalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawPolygonalSpring(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, nSides, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawPolygon(int nDurationType, int nVFX, location lCenter, float fRadius, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawPolygonalSpring(nDurationType, nVFX, lCenter, fRadius, fRadius, 0.0, 0.0, nSides, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawPentaclicSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    if (fRev == 0.0) fRev = 5.0;
    float fSidesToDraw = (fRev > 0.0) ? fRev*5.0 : -fRev*5.0;
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDecay = (fRadiusStart - fRadiusEnd)/fSidesToDraw; // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per node
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2;
    float fStarangle = (fRev > 0.0) ? 144.0 : -144.0;
    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fStarangle*f + fRotate;
        fAngle2 = fStarangle*g + fRotate;
        vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*f)*cos(fAngle1), (fRadiusStart - fDecay*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*g)*cos(fAngle2), (fRadiusStart - fDecay*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        DelayCommand(f*fDelayPerSide, DrawLineFromVectorToVector(nDurationType, nVFX, oArea, vPos1, vPos2, fDuration, nFrequencyPerSide, fDelayPerSide));
    }
}

void DrawPentaclicSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawPentaclicSpring(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawPentacle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawPentaclicSpring(nDurationType, nVFX, lCenter, fRadius, fRadius, 0.0, 0.0, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawStarSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i, toggle;
    if (nSides < 2) nSides = 3;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    if (fRev == 0.0) fRev = 5.0;
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides*2) : -fRev*IntToFloat(nSides*2);
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDecayInner = (fRadiusStartInner - fRadiusEndInner)/fSidesToDraw; // change in radius per node
    float fDecayOuter = (fRadiusStartOuter - fRadiusEndOuter)/fSidesToDraw; // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per node
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2;
    float fStarangle = (fRev > 0.0) ? 360.0/IntToFloat(nSides*2) : -360.0/IntToFloat(nSides*2);
    for (i = 0; i < nSidesToDraw; i++)
    {
        toggle ^= 1;
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fStarangle*f + fRotate;
        fAngle2 = fStarangle*g + fRotate;
        if (!toggle)
        {
            vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStartInner - fDecayInner*f)*cos(fAngle1), (fRadiusStartInner - fDecayInner*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
            vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStartOuter - fDecayOuter*g)*cos(fAngle2), (fRadiusStartOuter - fDecayOuter*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        }
        else
        {
            vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStartOuter - fDecayOuter*f)*cos(fAngle1), (fRadiusStartOuter - fDecayOuter*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
            vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStartInner - fDecayInner*g)*cos(fAngle2), (fRadiusStartInner - fDecayInner*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        }
        DelayCommand(f*fDelayPerSide, DrawLineFromVectorToVector(nDurationType, nVFX, oArea, vPos1, vPos2, fDuration, nFrequencyPerSide, fDelayPerSide));
    }
}

void DrawStarSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawStarSpring(nDurationType, nVFX, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, 0.0, 0.0, nSides, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawStar(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawStarSpring(nDurationType, nVFX, lCenter, fRadiusOuter, fRadiusInner, fRadiusOuter, fRadiusInner, 0.0, 0.0, nSides, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    if (fRev == 0.0) fRev = 5.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fSphereRadius, fSphereAngle;
    float fEffectiveHeight = fHeightEnd - fHeightStart;
    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        fSphereAngle = fTheta*f*0.25/fRev;
        fSphereRadius = fRadiusStart*cos(fSphereAngle) + fRadiusEnd*sin(fSphereAngle);
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSphereRadius*cos(fAngle), fSphereRadius*sin(fAngle), fEffectiveHeight*sin(fSphereAngle) + fHeightStart, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

void DrawSphere(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    if (nFrequency < 1) nFrequency = 90;
    if (fRev == 0.0) fRev = 5.0;
    DrawHemisphere(nDurationType, nVFX, lCenter, fRadius, 0.0, fRadius, 0.0, fDuration, nFrequency/2, fRev/2.0, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
    DrawHemisphere(nDurationType, nVFX, lCenter, fRadius, 0.0, fRadius, 2.0*fRadius, fDuration, nFrequency/2, -fRev/2.0, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawPolygonalHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nSides < 3) nSides = 3;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    if (fRev == 0.0) fRev = 5.0;
    float fEta = (fRev > 0.0) ? 360.0/IntToFloat(nSides) : -360.0/IntToFloat(nSides); // angle of segment
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides) : -fRev*IntToFloat(nSides); // total number of sides to draw including revolutions as float value
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions as int value
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2, fSphereRadius1, fSphereAngle1, fSphereRadius2, fSphereAngle2;
    float fEffectiveHeight = fHeightEnd - fHeightStart;
    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fEta*f + fRotate;
        fSphereAngle1 = fEta*f*0.25/fRev;
        fSphereRadius1 = fRadiusStart*cos(fSphereAngle1) + fRadiusEnd*sin(fSphereAngle1);
        fAngle2 = fEta*g + fRotate;
        fSphereAngle2 = fEta*g*0.25/fRev;
        fSphereRadius2 = fRadiusStart*cos(fSphereAngle2) + fRadiusEnd*sin(fSphereAngle2);
        vPos1 = gao_RotateVector(vCenter, sAxis, fSphereRadius1*cos(fAngle1), fSphereRadius1*sin(fAngle1), fEffectiveHeight*sin(fSphereAngle1) + fHeightStart, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, fSphereRadius2*cos(fAngle2), fSphereRadius2*sin(fAngle2), fEffectiveHeight*sin(fSphereAngle2) + fHeightStart, fDirectionXZ, fDirectionYZ);
        DelayCommand(f*fDelayPerSide, DrawLineFromVectorToVector(nDurationType, nVFX, oArea, vPos1, vPos2, fDuration, nFrequencyPerSide, fDelayPerSide));
    }
}

void DrawToroidalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, int nFrequency=90, float fLoopsPerRev=36.0f, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    float fRadiusStart = (fRadiusStartOuter + fRadiusStartInner)*0.5;
    float fRadiusEnd = (fRadiusEndOuter + fRadiusEndInner)*0.5;
    float fToricRadiusStart = (fRadiusStartOuter - fRadiusStartInner)*0.5;
    float fToricRadiusEnd = (fRadiusEndOuter - fRadiusEndInner)*0.5;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fDecay = (fRadiusStart - fRadiusEnd)/IntToFloat(nFrequency); // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fToricDecay = (fToricRadiusStart - fToricRadiusEnd)/IntToFloat(nFrequency); // change in radius of torus per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fToricAngle, fToricRadius;
    for (i=0; i<nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        fToricAngle = fLoopsPerRev*fAngle;
        fToricRadius = (fToricRadiusStart - fToricDecay*f);
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*f)*cos(fAngle) + fToricRadius*cos(fToricAngle)*cos(fAngle), (fRadiusStart - fDecay*f)*sin(fAngle) + fToricRadius*cos(fToricAngle)*sin(fAngle), fHeightStart - fGrowth*f + fToricRadius*sin(fToricAngle), fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

void DrawToroidalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fDuration=0.0f, int nFrequency=90, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawToroidalSpring(nDurationType, nVFX, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, 0.0, 0.0, fDuration, nFrequency, fLoopsPerRev, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawTorus(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, float fDuration=0.0f, int nFrequency=90, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawToroidalSpring(nDurationType, nVFX, lCenter, fRadiusOuter, fRadiusInner, fRadiusOuter, fRadiusInner, 0.0, 0.0, fDuration, nFrequency, fLoopsPerRev, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawRhodoneaSpring(int nDurationType, int nVFX, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fDist;
    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f;
        fDist = fRadius*sin(fRoulette*fAngle);
        fAngle += fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fDist*cos(fAngle), fDist*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

void DrawRhodonea(int nDurationType, int nVFX, location lCenter, float fRadius, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawRhodoneaSpring(nDurationType, nVFX, lCenter, fRadius, 0.0, 0.0, fRoulette, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawHypocycloidSpring(int nDurationType, int nVFX, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    if (fRoulette == 0.0) fRoulette = 3.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float fAlpha = fRadius - fRoulette;
    float fBeta = fAlpha/fRoulette;
    float f, x, y, fAngle, fDist;

    for (i = 0; i < nFrequency; i++)
    {
      f = IntToFloat(i);
      fAngle = fTheta*f;
      y = fAlpha*sin(fAngle) - fRoulette*sin(fBeta*fAngle);
      x = fAlpha*cos(fAngle) + fRoulette*cos(fBeta*fAngle);
      fDist = sqrt(pow(y, 2.0) + pow(x, 2.0));     // x -> 0; atan(y/x) -> 90;
      fAngle = (x == 0.0 && y < 0.0) ? 270.0 + fRotate : (x==0.0) ? 90.0 + fRotate : (x < 0.0) ? 180.0 + atan(y/x) + fRotate : atan(y/x) + fRotate;
      lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fDist*cos(fAngle), fDist*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
      DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
   }
}

void DrawHypocycloid(int nDurationType, int nVFX, location lCenter, float fRadius, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawHypocycloidSpring(nDurationType, nVFX, lCenter, fRadius, 0.0, 0.0, fRoulette, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawEpicycloidSpring(int nDurationType, int nVFX, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    if (fRoulette == 0.0) fRoulette = 3.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float fAlpha = fRadius + fRoulette;
    float fBeta = fAlpha/fRoulette;
    float f, x, y, fAngle, fDist;

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f;
        y = (fAlpha*sin(fAngle) - fRoulette*sin(fBeta*fAngle));
        x = (fAlpha*cos(fAngle) - fRoulette*cos(fBeta*fAngle));
        fDist = sqrt(pow(y, 2.0) + pow(x, 2.0));
        fAngle = (x == 0.0 && y < 0.0) ? 270.0 + fRotate : (x==0.0) ? 90.0 + fRotate : (x < 0.0) ? 180.0 + atan(y/x) + fRotate : atan(y/x) + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fDist*cos(fAngle), fDist*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

void DrawEpicycloid(int nDurationType, int nVFX, location lCenter, float fRadius, float fRoulette=3.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    DrawEpicycloidSpring(nDurationType, nVFX, lCenter, fRadius, 0.0, 0.0, fRoulette, fDuration, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ);
}

void DrawSinusoid(int nDurationType, int nVFX, location lCenter, float fRadius, float fLength, float fDirection=0.0f, float fDuration=0.0f, int nFrequency=90, float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f)
{
    int i;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 6.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fEta = fLength/IntToFloat(nFrequency); // horizontal distance between each node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    vector v, vTemp;
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fSine;

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        fSine = sin(fAngle);
        v = Vector(fEta*f, fRadius*fSine, 0.0);
        vTemp = VectorMagnitude(v)*AngleToVector(VectorToAngle(v) + fDirection);
        fAngle = (fSine > 0.0) ? 360.0 - fAngle : fAngle ;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, vTemp.x, vTemp.y, 0.0, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, ApplyEffectAtLocation(nDurationType, EffectVisualEffect(nVFX), lPos, fDuration));
    }
}

/*
   =============================================
   PLACE* FUNCTIONS
   =============================================
*/

object ObjectPlaceEllipticalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_ELLIPTICALSPRING")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fWait < 1.0) fWait = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    fRadiusStartOuter = (fRadiusStartOuter == 0.0) ? 0.01 : (fRadiusStartOuter < 0.0) ? -fRadiusStartOuter : fRadiusStartOuter ;
    fRadiusStartInner = (fRadiusStartInner == 0.0) ? 0.01 : (fRadiusStartInner < 0.0) ? -fRadiusStartInner : fRadiusStartInner ;
    fRadiusEndOuter = (fRadiusEndOuter == 0.0) ? 0.01 : (fRadiusEndOuter < 0.0) ? -fRadiusEndOuter : fRadiusEndOuter ;
    fRadiusEndInner = (fRadiusEndInner == 0.0) ? 0.01 : (fRadiusEndInner < 0.0) ? -fRadiusEndInner : fRadiusEndInner ;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fInnerDecay = (fRadiusStartInner - fRadiusEndInner)/IntToFloat(nFrequency); // change in radius per node
    float fOuterDecay = (fRadiusStartOuter - fRadiusEndOuter)/IntToFloat(nFrequency); // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fElliRadius, fElliAngle, fRadiusOuter, fEccentric;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fElliAngle = fTheta*f;
        fAngle = fElliAngle + fRotate;
        fRadiusOuter = fRadiusStartOuter - fOuterDecay*f;
        fEccentric = 1 - (pow(fRadiusStartInner - fInnerDecay*f, 2.0)/pow(fRadiusOuter, 2.0));
        fElliRadius =  fRadiusOuter*sqrt((1 - fEccentric)/(1 - fEccentric*pow(cos(fElliAngle), 2.0)));
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fElliRadius*cos(fAngle), fElliRadius*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceEllipticalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceEllipticalSpring(sTemplate, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, fHeightStart, fHeightEnd, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceEllipticalSpiral(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceEllipticalSpring(sTemplate, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, 0.0, 0.0, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_ELLIPTICALSPIRAL");
}

void PlaceEllipse(string sTemplate, location lCenter, float fRadiusOuter, float fRadiusInner, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceEllipticalSpring(sTemplate, lCenter, fRadiusOuter, fRadiusInner, fRadiusOuter, fRadiusInner, 0.0, 0.0, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_ELLIPSE");
}

object ObjectPlaceSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_SPRING")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fWait < 1.0) fWait = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fDecay = (fRadiusStart - fRadiusEnd)/IntToFloat(nFrequency); // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*f)*cos(fAngle), (fRadiusStart - fDecay*f)*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceSpring(sTemplate, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceSpiral(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceSpring(sTemplate, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_SPIRAL");
}

void PlaceCircle(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceSpring(sTemplate, lCenter, fRadius, fRadius, 0.0, 0.0, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_CIRCLE");
}

void PlaceLineToCenter(string sTemplate, location lCenter, float fLength, float fDirection=0.0f, int nFrequency=60, float fTime=12.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceSpring(sTemplate, lCenter, fLength, 0.0, 0.0, 0.0, nFrequency, 0.0, fTime, fDirection, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_LINETO");
}

void PlaceLineFromCenter(string sTemplate, location lCenter, float fLength, float fDirection=0.0f, int nFrequency=60, float fTime=12.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceSpring(sTemplate, lCenter, 0.0, fLength, 0.0, 0.0, nFrequency, 0.0, fTime, fDirection, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_LINEFROM");
}

object ObjectPlacePolygonalSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_POLYGONALSPRING")
{
    int i;
    if (nSides < 3) nSides = 3;
    if (nFrequency < 1) nFrequency = 60;
    if (fWait < 1.0) fWait = 1.0;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fEta = (fRev > 0.0) ? 360.0/IntToFloat(nSides) : -360.0/IntToFloat(nSides); // angle of segment
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides) : -fRev*IntToFloat(nSides); // total number of sides to draw including revolutions as float value
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions as int value
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDecay = (fRadiusStart - fRadiusEnd)/fSidesToDraw; // change in radius per side
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per side
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fEta*f + fRotate;
        fAngle2 = fEta*g + fRotate;
        vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*f)*cos(fAngle1), (fRadiusStart - fDecay*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*g)*cos(fAngle2), (fRadiusStart - fDecay*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        DelayCommand(f*fDelayPerSide, PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlacePolygonalSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlacePolygonalSpring(sTemplate, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nSides, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlacePolygonalSpiral(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nSides=3, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlacePolygonalSpring(sTemplate, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, nSides, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_POLYGONALSPIRAL");
}

void PlacePolygon(string sTemplate, location lCenter, float fRadius, int nSides=3, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlacePolygonalSpring(sTemplate, lCenter, fRadius, fRadius, 0.0, 0.0, nSides, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_POLYGON");
}

object ObjectPlacePentaclicSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_PENTACLICSPRING")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fWait < 1.0) fWait = 1.0;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fSidesToDraw = (fRev > 0.0) ? fRev*5.0 : -fRev*5.0;
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDecay = (fRadiusStart - fRadiusEnd)/fSidesToDraw; // change in radius per side
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per side
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2;
    float fStarangle = (fRev > 0.0) ? 144.0 : -144.0;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fStarangle*f + fRotate;
        fAngle2 = fStarangle*g + fRotate;
        vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStart-fDecay*f)*cos(fAngle1), (fRadiusStart-fDecay*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStart-fDecay*g)*cos(fAngle2), (fRadiusStart-fDecay*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        DelayCommand(f*fDelayPerSide, PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlacePentaclicSpring(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlacePentaclicSpring(sTemplate, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlacePentaclicSpiral(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlacePentaclicSpring(sTemplate, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_PENTACLICSPIRAL");
}

void PlacePentacle(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlacePentaclicSpring(sTemplate, lCenter, fRadius, fRadius, 0.0, 0.0, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_PENTACLE");
}

object ObjectPlaceStarSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_STARSPRING")
{
    int i, toggle;
    if (nSides < 2) nSides = 3;
    if (nFrequency < 1) nFrequency = 60;
    if (fWait < 1.0) fWait = 1.0;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides*2) : -fRev*IntToFloat(nSides*2);
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDecayInner = (fRadiusStartInner - fRadiusEndInner)/fSidesToDraw; // change in radius per side
    float fDecayOuter = (fRadiusStartOuter - fRadiusEndOuter)/fSidesToDraw; // change in radius per side
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per side
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2;
    float fStarangle = (fRev > 0.0) ? 360.0/IntToFloat(nSides*2) : -360.0/IntToFloat(nSides*2);

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nSidesToDraw; i++)
    {
        toggle ^= 1;
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fStarangle*f + fRotate;
        fAngle2 = fStarangle*g + fRotate;
        if (!toggle)
        {
            vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStartInner - fDecayInner*f)*cos(fAngle1), (fRadiusStartInner - fDecayInner*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
            vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStartOuter - fDecayOuter*g)*cos(fAngle2), (fRadiusStartOuter - fDecayOuter*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        }
        else
        {
            vPos1 = gao_RotateVector(vCenter, sAxis, (fRadiusStartOuter - fDecayOuter*f)*cos(fAngle1), (fRadiusStartOuter - fDecayOuter*f)*sin(fAngle1), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ);
            vPos2 = gao_RotateVector(vCenter, sAxis, (fRadiusStartInner - fDecayInner*g)*cos(fAngle2), (fRadiusStartInner - fDecayInner*g)*sin(fAngle2), fHeightStart - fGrowth*g, fDirectionXZ, fDirectionYZ);
        }
        DelayCommand(f*fDelayPerSide, PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceStarSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceStarSpring(sTemplate, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, fHeightStart, fHeightEnd, nSides, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceStarSpiral(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceStarSpring(sTemplate, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, 0.0, 0.0, nSides, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_STARSPIRAL");
}

void PlaceStar(string sTemplate, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceStarSpring(sTemplate, lCenter, fRadiusOuter, fRadiusInner, fRadiusOuter, fRadiusInner, 0.0, 0.0, nSides, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_STAR");
}

object ObjectPlaceHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_HEMISPHERE")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fDecay = (fRadiusStart - fRadiusEnd)/IntToFloat(nFrequency); // change in radius per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fSphereRadius, fSphereAngle;
    float fEffectiveHeight = fHeightEnd - fHeightStart;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        fSphereAngle = fTheta*f*0.25/fRev;
        fSphereRadius = fRadiusStart*cos(fSphereAngle) + fRadiusEnd*sin(fSphereAngle);
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSphereRadius*cos(fAngle), fSphereRadius*sin(fAngle), fEffectiveHeight*sin(fSphereAngle) + fHeightStart, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceHemisphere(sTemplate, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceSphere(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    if (nFrequency < 1) nFrequency = 60;
    if (fRev == 0.0) fRev = 5.0;
    ObjectPlaceHemisphere(sTemplate, lCenter, fRadius, 0.0, fRadius, 0.0, nFrequency/2, fRev/2.0, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
    ObjectPlaceHemisphere(sTemplate, lCenter, fRadius, 0.0, fRadius, 2.0*fRadius, nFrequency/2, -fRev/2.0, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

object ObjectPlacePolygonalHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_POLYGONALHEMISPHERE")
{
    int i;
    if (nSides < 3) nSides = 3;
    if (nFrequency < 1) nFrequency = 90;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fEta = (fRev > 0.0) ? 360.0/IntToFloat(nSides) : -360.0/IntToFloat(nSides); // angle of segment
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides) : -fRev*IntToFloat(nSides); // total number of sides to draw including revolutions as float value
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions as int value
    int nFrequencyPerSide = FloatToInt(IntToFloat(nFrequency)/fSidesToDraw);
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos1, vPos2;
    object oArea = GetAreaFromLocation(lCenter);
    float f, g, fAngle1, fAngle2, fSphereRadius1, fSphereAngle1, fSphereRadius2, fSphereAngle2;
    float fEffectiveHeight = fHeightEnd - fHeightStart;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        fAngle1 = fEta*f + fRotate;
        fSphereAngle1 = fEta*f*0.25/fRev;
        fSphereRadius1 = fRadiusStart*cos(fSphereAngle1) + fRadiusEnd*sin(fSphereAngle1);
        fAngle2 = fEta*g + fRotate;
        fSphereAngle2 = fEta*g*0.25/fRev;
        fSphereRadius2 = fRadiusStart*cos(fSphereAngle2) + fRadiusEnd*sin(fSphereAngle2);
        vPos1 = gao_RotateVector(vCenter, sAxis, fSphereRadius1*cos(fAngle1), fSphereRadius1*sin(fAngle1), fEffectiveHeight*sin(fSphereAngle1) + fHeightStart, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, fSphereRadius2*cos(fAngle2), fSphereRadius2*sin(fAngle2), fEffectiveHeight*sin(fSphereAngle2) + fHeightStart, fDirectionXZ, fDirectionYZ);
        DelayCommand(f*fDelayPerSide, PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlacePolygonalHemisphere(string sTemplate, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlacePolygonalHemisphere(sTemplate, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nSides, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

object ObjectPlaceSinusoid(string sTemplate, location lCenter, float fRadius, float fLength, float fDirection=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_SINUSOID")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fWait < 1.0) fWait = 1.0;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fEta = fLength/IntToFloat(nFrequency); // horizontal distance between each node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    vector v, vTemp;
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fSine;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        fSine = sin(fAngle);
        v = Vector(fEta*f, fRadius*fSine, 0.0);
        vTemp = VectorMagnitude(v)*AngleToVector(VectorToAngle(v) + fDirection);
        fAngle = (fSine > 0.0) ? 360.0 - fAngle : fAngle ;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, vTemp.x, vTemp.y, 0.0, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceSinusoid(string sTemplate, location lCenter, float fRadius, float fLength, float fDirection=0.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceSinusoid(sTemplate, lCenter, fRadius, fLength, fDirection, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

object ObjectPlaceToroidalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_TOROIDALSPRING")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fWait < 1.0) fWait = 1.0;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fRadiusStart = (fRadiusStartOuter + fRadiusStartInner)*0.5;
    float fRadiusEnd = (fRadiusEndOuter + fRadiusEndInner)*0.5;
    float fToricRadiusStart = (fRadiusStartOuter - fRadiusStartInner)*0.5;
    float fToricRadiusEnd = (fRadiusEndOuter - fRadiusEndInner)*0.5;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fDecay = (fRadiusStart - fRadiusEnd)/IntToFloat(nFrequency); // change in radius per node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fToricDecay = (fToricRadiusStart - fToricRadiusEnd)/IntToFloat(nFrequency); // change in radius of torus per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fToricAngle, fToricRadius;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f + fRotate;
        fToricAngle = fLoopsPerRev*fAngle;
        fToricRadius = fToricRadiusStart - fToricDecay*f;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, (fRadiusStart - fDecay*f)*cos(fAngle) + fToricRadius*cos(fToricAngle)*cos(fAngle), (fRadiusStart - fDecay*f)*sin(fAngle) + fToricRadius*cos(fToricAngle)*sin(fAngle), fHeightStart - fGrowth*f + fToricRadius*sin(fToricAngle), fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceToroidalSpring(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceToroidalSpring(sTemplate, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, fHeightStart, fHeightEnd, nFrequency, fLoopsPerRev, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceToroidalSpiral(string sTemplate, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceToroidalSpring(sTemplate, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, 0.0, 0.0, nFrequency, fLoopsPerRev, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_TOROIDALSPIRAL");
}

void PlaceTorus(string sTemplate, location lCenter, float fRadiusOuter, float fRadiusInner, int nFrequency=60, float fLoopsPerRev=36.0f, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceToroidalSpring(sTemplate, lCenter, fRadiusOuter, fRadiusInner, fRadiusOuter, fRadiusInner, 0.0, 0.0, nFrequency, fLoopsPerRev, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_TORUS");
}

object ObjectPlaceStellaOctangula(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_STELLAOCTANGULA")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (nFrequency < 1) nFrequency = 60;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma = fRadius*2.0/3.0;
    float fEpsilon = fSigma*4.0/3.0/cos(19.47122063449069136924599933997);
    int nFrequencyPerSide = nFrequency/12;
    float fDelayPerSide = fTime/12.0;
    float f, z1, fAngle1, g, z2, fAngle2;
    vector vPos1, vPos2, vTop;
    vTop = gao_RotateVector(vCenter, sAxis, 0.0, 0.0, 3.0*fSigma, fDirectionXZ, fDirectionYZ);

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < 6; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        if (i < 3)
        {
            fAngle1 = fRotate + 120.0*f;
            fAngle2 = fRotate + 120.0*g;
            z1 = 2.0*fSigma;
            z2 = 2.0*fSigma;
        }
        else
        {
            fAngle1 = fRotate + 120.0*f + 60.0 ;
            fAngle2 = fRotate + 120.0*g + 60.0 ;
            z1 = fSigma;
            z2 = fSigma;
        }
        vPos1 = gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle1), fEpsilon*sin(fAngle1), z1, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle2), fEpsilon*sin(fAngle2), z2, fDirectionXZ, fDirectionYZ);

        if (i<3) DelayCommand(fDelayPerSide*f, PlaceLineFromVectorToVector(sTemplate, oArea, vCenter, vPos1, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
        else     DelayCommand(fDelayPerSide*(f+6.0), PlaceLineFromVectorToVector(sTemplate, oArea, vTop, vPos1, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
        DelayCommand(fDelayPerSide*(f+3.0), PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceStellaOctangula(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceStellaOctangula(sTemplate, lCenter, fRadius, nFrequency, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

object ObjectPlaceIcosahedron(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_ICOSAHEDRON")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (nFrequency < 1) nFrequency = 60;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma1 = fRadius*0.55278640450004206071816526625413;
    float fSigma2 = fRadius*0.89442719099991587856366946749173;
    float fEpsilon = fRadius*0.89442719099991587856366946749256;
    int nFrequencyPerSide = nFrequency/30;
    float fDelayPerSide = fTime/30.0;
    float f, z1, fAngle1, g, z2, fAngle2;
    vector vPos1, vPos2, vTop;
    vTop = gao_RotateVector(vCenter, sAxis, 0.0, 0.0, 2.0*fSigma1 + fSigma2, fDirectionXZ, fDirectionYZ);

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < 20; i++)
    {
        f = IntToFloat(i);
        g = IntToFloat(i+1);
        if (i < 5)
        {
            fAngle1 = fRotate + f*72.0;
            fAngle2 = fRotate + g*72.0;
            z1 = fSigma1;
            z2 = fSigma1;
        }
        else if (i < 10)
        {
            fAngle1 = fRotate + f*72.0;
            fAngle2 = fRotate + f*72.0 + 36.0;
            z1 = fSigma1;
            z2 = fSigma1 + fSigma2;
        }
        else if (i < 15)
        {
            fAngle1 = fRotate + f*72.0;
            fAngle2 = fRotate + f*72.0 - 36.0;
            z1 = fSigma1;
            z2 = fSigma1 + fSigma2;
        }
        else
        {
            fAngle1 = fRotate + f*72.0 + 36.0;
            fAngle2 = fRotate + g*72.0 + 36.0;
            z1 = fSigma1 + fSigma2;
            z2 = fSigma1 + fSigma2;
        }
        vPos1 = gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle1), fEpsilon*sin(fAngle1), z1, fDirectionXZ, fDirectionYZ);
        vPos2 = gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle2), fEpsilon*sin(fAngle2), z2, fDirectionXZ, fDirectionYZ);

        if (i < 5)
        {
            DelayCommand(fDelayPerSide*f, PlaceLineFromVectorToVector(sTemplate, oArea, vCenter, vPos1, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
            DelayCommand(fDelayPerSide*(f+5.0), PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
        }
        else if (i < 10)
        {
            DelayCommand(fDelayPerSide*(f+5.0), PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
        }
        else if (i < 15)
        {
            DelayCommand(fDelayPerSide*(f+5.0), PlaceLineFromVectorToVector(sTemplate, oArea, vPos2, vPos1, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
        }
        else
        {
            DelayCommand(fDelayPerSide*(f+10.0), PlaceLineFromVectorToVector(sTemplate, oArea, vTop, vPos1, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
            DelayCommand(fDelayPerSide*(f+5.0), PlaceLineFromVectorToVector(sTemplate, oArea, vPos1, vPos2, nFrequencyPerSide, fDelayPerSide, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
        }
    }

    return oData;
}

void PlaceIcosahedron(string sTemplate, location lCenter, float fRadius, int nFrequency=60, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceIcosahedron(sTemplate, lCenter, fRadius, nFrequency, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

object ObjectPlaceRhodoneaSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_RHODONEASPRING")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fWait < 1.0) fWait = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float f, fAngle, fDist;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f;
        fDist = fRadius*sin(fRoulette*fAngle);
        fAngle += fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fDist*cos(fAngle), fDist*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceRhodoneaSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceRhodoneaSpring(sTemplate, lCenter, fRadius, fHeightStart, fHeightEnd, fRoulette, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceRhodonea(string sTemplate, location lCenter, float fRadius, float fRoulette=3.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceRhodoneaSpring(sTemplate, lCenter, fRadius, 0.0, 0.0, fRoulette, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_RHODONEA");
}

object ObjectPlaceHypocycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_HYPOCYCLOIDSPRING")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fWait < 1.0) fWait = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    if (fRoulette == 0.0) fRoulette = 3.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float fAlpha = fRadius - fRoulette;
    float fBeta = fAlpha/fRoulette; // DIVIDE BY ZERO
    float f, x, y, fAngle, fDist;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f;
        y = (fAlpha*sin(fAngle) - fRoulette*sin(fBeta*fAngle));
        x = (fAlpha*cos(fAngle) + fRoulette*cos(fBeta*fAngle));
        fDist = sqrt(pow(y, 2.0) + pow(x, 2.0));
        fAngle = (x == 0.0 && y < 0.0) ? 270.0 + fRotate : (x==0.0) ? 90.0 + fRotate : (x < 0.0) ? 180.0 + atan(y/x) + fRotate : atan(y/x) + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fDist*cos(fAngle), fDist*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceHypocycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceHypocycloidSpring(sTemplate, lCenter, fRadius, fHeightStart, fHeightEnd, fRoulette, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceHypocycloid(string sTemplate, location lCenter, float fRadius, float fRoulette=3.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceHypocycloidSpring(sTemplate, lCenter, fRadius, 0.0, 0.0, fRoulette, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_HYPOCYCLOID");
}

object ObjectPlaceEpicycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f, string sTag="PSC_P_EPICYCLOIDSPRING")
{
    int i;
    if (nFrequency < 1) nFrequency = 60;
    if (fTime < 0.0) fTime = 12.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fWait < 1.0) fWait = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    if (fRoulette == 0.0) fRoulette = 3.0;
    float fTheta = 360.0*fRev/IntToFloat(nFrequency); // angle between each node
    float fGrowth = (fHeightStart - fHeightEnd)/IntToFloat(nFrequency); // change in height per node
    float fDelay = fTime/IntToFloat(nFrequency);
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    location lPos;
    float fAlpha = fRadius + fRoulette;
    float fBeta = fAlpha/fRoulette;
    float f, x, y, fAngle, fDist;

    object oData = (fLifetime > 0.0) ? OBJECT_INVALID : CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);

    for (i = 0; i < nFrequency; i++)
    {
        f = IntToFloat(i);
        fAngle = fTheta*f;
        y = (fAlpha*sin(fAngle) - fRoulette*sin(fBeta*fAngle));
        x = (fAlpha*cos(fAngle) - fRoulette*cos(fBeta*fAngle));
        fDist = sqrt(pow(y, 2.0) + pow(x, 2.0));
        fAngle = (x == 0.0 && y < 0.0) ? 270.0 + fRotate : (x==0.0) ? 90.0 + fRotate : (x < 0.0) ? 180.0 + atan(y/x) + fRotate : atan(y/x) + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fDist*cos(fAngle), fDist*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelay, gao_ActionCreateObject(sTemplate, lPos, nDurationType, nVFX, fDuration, fWait, fLifetime, oData));
    }

    return oData;
}

void PlaceEpicycloidSpring(string sTemplate, location lCenter, float fRadius, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fRoulette=3.0f, int nFrequency=60, float fRev=5.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceEpicycloidSpring(sTemplate, lCenter, fRadius, fHeightStart, fHeightEnd, fRoulette, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime);
}

void PlaceEpicycloid(string sTemplate, location lCenter, float fRadius, float fRoulette=3.0f, int nFrequency=60, float fRev=1.0f, float fTime=12.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType=-1, int nVFX=-1, float fDuration=0.0f, float fWait=1.0f, float fLifetime=0.0f)
{
    ObjectPlaceEpicycloidSpring(sTemplate, lCenter, fRadius, 0.0, 0.0, fRoulette, nFrequency, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType, nVFX, fDuration, fWait, fLifetime, "PSC_P_EPICYCLOID");
}

/*
   =============================================
   BEAM FUNCTIONS
   =============================================
*/

object ObjectBeamPolygonalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_POLYGONALSPRING")
{
    int i;
    if (nSides < 3) nSides = 3;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fEta = (fRev > 0.0) ? 360.0/IntToFloat(nSides) : -360.0/IntToFloat(nSides); // angle of segment
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides) : -fRev*IntToFloat(nSides); // total number of sides to draw including revolutions as float value
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions as int value
    float fDecay = (fRadiusStart - fRadiusEnd)/fSidesToDraw; // change in radius per side
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per side
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float f, fAngle;
    object oData;
    location lPos;
    float fWait = 1.0;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", nSidesToDraw + 1)));

    for (i = 0; i <= nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        fAngle = fEta*f + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, (fRadiusStart-fDecay*f)*cos(fAngle), (fRadiusStart-fDecay*f)*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelayPerSide, gao_ActionCreateLocalObject(sTemplate, lPos, "store" + IntToString(i), oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
        if (i > 0) DelayCommand(f*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i-1), "store" + IntToString(i), nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
       DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
       return OBJECT_INVALID;
    }
    return oData;
}

void BeamPolygonalSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamPolygonalSpring(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nSides, fDuration, sTemplate, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

void BeamPolygonalSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamPolygonalSpring(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, nSides, fDuration, sTemplate, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime, "PSC_B_POLYGONALSPIRAL");
}

object ObjectBeamPolygon(int nDurationType, int nVFX, location lCenter, float fRadius, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_POLYGON")
{
    int i;
    if (nSides < 3) nSides = 3;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fEta = (fRev > 0.0) ? 360.0/IntToFloat(nSides) : -360.0/IntToFloat(nSides); // angle of segment
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides) : -fRev*IntToFloat(nSides); // total number of sides to draw including revolutions as float value
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions as int value
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos;
    object oArea = GetAreaFromLocation(lCenter);
    float f, x, y, fAngle;
    object oData;
    location lPos;
    float fWait = 1.0;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", nSidesToDraw)));

    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        fAngle = fEta*f + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fRadius*cos(fAngle), fRadius*sin(fAngle), 0.0, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelayPerSide, gao_ActionCreateLocalObject(sTemplate, lPos, "store" + IntToString(i), oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
        if (i>0) DelayCommand(f*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i-1), "store" + IntToString(i), nDurationType, nVFX, fDuration));
        if (fRev == 1.0 && i == nSidesToDraw-1) DelayCommand(fSidesToDraw*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i), "store0", nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamPolygon(int nDurationType, int nVFX, location lCenter, float fRadius, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamPolygon(nDurationType, nVFX, lCenter, fRadius, nSides, fDuration, sTemplate, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamPentaclicSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_PENTACLICSPRING")
{
    int i;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fSidesToDraw = (fRev > 0.0) ? fRev*5.0 : -fRev*5.0;
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    float fDecay = (fRadiusStart - fRadiusEnd)/fSidesToDraw; // change in radius per side
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per side
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float f, fAngle;
    float fStarangle = (fRev > 0.0) ? 144.0 : -144.0;
    object oData;
    location lPos;
    float fWait = 1.0;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", nSidesToDraw+1)));

    for (i = 0; i <= nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        fAngle = fStarangle*f + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, (fRadiusStart-fDecay*f)*cos(fAngle), (fRadiusStart-fDecay*f)*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelayPerSide, gao_ActionCreateLocalObject(sTemplate, lPos, "store" + IntToString(i), oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
        if (i > 0) DelayCommand(f*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i-1), "store" + IntToString(i), nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamPentaclicSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamPentaclicSpring(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, fDuration, sTemplate, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

void BeamPentaclicSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamPentaclicSpring(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, 0.0, 0.0, fDuration, sTemplate, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime, "PSC_B_PENTACLICSPIRAL");
}

object ObjectBeamPentacle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_PENTACLE")
{
    int i;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fSidesToDraw = (fRev > 0.0) ? fRev*5.0 : -fRev*5.0;
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos;
    object oArea = GetAreaFromLocation(lCenter);
    float f, x, y, fAngle;
    float fStarangle = (fRev > 0.0) ? 144.0 : -144.0;
    object oData;
    location lPos;
    float fWait = 1.0;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", nSidesToDraw)));

    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        fAngle = fStarangle*f + fRotate;
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fRadius*cos(fAngle), fRadius*sin(fAngle), 0.0, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelayPerSide, gao_ActionCreateLocalObject(sTemplate, lPos, "store" + IntToString(i), oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
        if (i>0) DelayCommand(f*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i-1), "store" + IntToString(i), nDurationType, nVFX, fDuration));
        if (fRev == 1.0 && i == nSidesToDraw-1) DelayCommand(fSidesToDraw*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i), "store0", nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamPentacle(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamPentacle(nDurationType, nVFX, lCenter, fRadius, fDuration, sTemplate, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamStarSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_STARSPRING")
{
    int i, toggle;
    if (nSides < 2) nSides = 3;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides*2) : -fRev*IntToFloat(nSides*2);
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    float fDecayOuter = (fRadiusStartOuter - fRadiusEndOuter)/fSidesToDraw; // change in radius per side
    float fDecayInner = (fRadiusStartInner - fRadiusEndInner)/fSidesToDraw; // change in radius per side
    float fGrowth = (fHeightStart - fHeightEnd)/fSidesToDraw; // change in height per side
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float f, fAngle;
    float fStarangle = (fRev > 0.0) ? 360.0/IntToFloat(2*nSides) : -360.0/IntToFloat(2*nSides);
    object oData;
    location lPos;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", nSidesToDraw+1)));

    for (i = 0; i <= nSidesToDraw; i++)
    {
        toggle ^= 1;
        f = IntToFloat(i);
        fAngle = fStarangle*f + fRotate;
        if (!toggle) lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, (fRadiusStartInner - fDecayInner*f)*cos(fAngle), (fRadiusStartInner - fDecayInner*f)*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        else         lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, (fRadiusStartOuter - fDecayOuter*f)*cos(fAngle), (fRadiusStartOuter - fDecayOuter*f)*sin(fAngle), fHeightStart - fGrowth*f, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelayPerSide, gao_ActionCreateLocalObject(sTemplate, lPos, "store" + IntToString(i), oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
        if (i>0) DelayCommand(f*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i-1), "store" + IntToString(i), nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamStarSpring(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
     ObjectBeamStarSpring(nDurationType, nVFX, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, fHeightStart, fHeightEnd, nSides, fDuration, sTemplate, fRev, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

void BeamStarSpiral(int nDurationType, int nVFX, location lCenter, float fRadiusStartOuter, float fRadiusStartInner, float fRadiusEndOuter=0.0f, float fRadiusEndInner=0.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
     ObjectBeamStarSpring(nDurationType, nVFX, lCenter, fRadiusStartOuter, fRadiusStartInner, fRadiusEndOuter, fRadiusEndInner, 0.0, 0.0, nSides, fDuration, sTemplate, fRev, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime, "PSC_B_STARSPIRAL");
}

object ObjectBeamStar(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_STAR")
{
    int i, toggle;
    if (nSides < 2) nSides = 3;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 1.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(2*nSides) : -fRev*IntToFloat(2*nSides);
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos;
    object oArea = GetAreaFromLocation(lCenter);
    float f, x, y, fAngle;
    float fStarangle = (fRev > 0.0) ? 360.0/IntToFloat(2*nSides) : -360.0/IntToFloat(2*nSides);
    object oData;
    location lPos;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", nSidesToDraw)));

    for (i = 0; i < nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        toggle ^= 1;
        fAngle = fStarangle*f + fRotate;
        if (!toggle) lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fRadiusInner*cos(fAngle), fRadiusInner*sin(fAngle), 0.0, fDirectionXZ, fDirectionYZ), fAngle);
        else         lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fRadiusOuter*cos(fAngle), fRadiusOuter*sin(fAngle), 0.0, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelayPerSide, gao_ActionCreateLocalObject(sTemplate, lPos, "store" + IntToString(i), oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
        if (i > 0) DelayCommand(f*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i-1), "store" + IntToString(i), nDurationType, nVFX, fDuration));
        if (fRev == 1.0 && i == nSidesToDraw-1) DelayCommand(fSidesToDraw*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i), "store0", nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamStar(int nDurationType, int nVFX, location lCenter, float fRadiusOuter, float fRadiusInner, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=1.0f, float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamStar(nDurationType, nVFX, lCenter, fRadiusOuter, fRadiusInner, nSides, fDuration, sTemplate, fRev, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamLineFromCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_LINEFROM")
{
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    object oArea = GetAreaFromLocation(lCenter);
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos = fLength*AngleToVector(fDirection);
    vector vPos2;
    float fWait = 1.0;

    vPos2 = gao_RotateVector(vCenter, sAxis, vPos.x, vPos.y, vPos.z, fDirectionXZ, fDirectionYZ);

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 2)));

    gao_ActionCreateLocalObject(sTemplate, lCenter, "store0", oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
    DelayCommand(fTime, gao_ActionCreateLocalObject(sTemplate, Location(oArea, vPos2, fDirection), "store1", oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));

    DelayCommand(fTime+1.0, gao_ActionApplyLocalBeamEffect(oData, "store0", "store1", nDurationType, nVFX, fDuration));

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamLineFromCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamLineFromCenter(nDurationType, nVFX, lCenter, fLength, fDirection, fDuration, sTemplate, fTime, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamLineToCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_LINETO")
{
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    object oArea = GetAreaFromLocation(lCenter);
    vector vCenter = GetPositionFromLocation(lCenter);
    vector vPos = fLength*AngleToVector(fDirection);
    vector vPos2;
    float fWait = 1.0;

    vPos2 = gao_RotateVector(vCenter, sAxis, vPos.x, vPos.y, vPos.z, fDirectionXZ, fDirectionYZ);

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 2)));

    DelayCommand(fTime, gao_ActionCreateLocalObject(sTemplate, lCenter, "store0", oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    gao_ActionCreateLocalObject(sTemplate, Location(oArea, vPos2, fDirection), "store1", oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);

    DelayCommand(fTime+1.0, gao_ActionApplyLocalBeamEffect(oData, "store1", "store0", nDurationType, nVFX, fDuration));

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamLineToCenter(int nDurationType, int nVFX, location lCenter, float fLength, float fDirection=0.0f, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamLineToCenter(nDurationType, nVFX, lCenter, fLength, fDirection, fDuration, sTemplate, fTime, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamPolygonalHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_POLYGONALHEMISPHERE")
{
    int i;
    if (nSides < 3) nSides = 3;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (fRev == 0.0) fRev = 5.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fEta = (fRev > 0.0) ? 360.0/IntToFloat(nSides) : -360.0/IntToFloat(nSides); // angle of segment
    float fSidesToDraw = (fRev > 0.0) ? fRev*IntToFloat(nSides) : -fRev*IntToFloat(nSides); // total number of sides to draw including revolutions as float value
    int nSidesToDraw = FloatToInt(fSidesToDraw); // total number of sides to draw including revolutions as int value
    float fDelayPerSide = fTime/fSidesToDraw;
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float f, fAngle, fSphereAngle, fSphereRadius;
    float fEffectiveHeight = fHeightEnd - fHeightStart;
    object oData;
    location lPos;
    float fWait = 1.0;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", nSidesToDraw+1)));

    for (i = 0; i <= nSidesToDraw; i++)
    {
        f = IntToFloat(i);
        fAngle = fEta*f + fRotate;
        fSphereAngle = fEta*f*0.25/fRev;
        fSphereRadius = fRadiusStart*cos(fSphereAngle) + fRadiusEnd*sin(fSphereAngle);
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSphereRadius*cos(fAngle), fSphereRadius*sin(fAngle), fEffectiveHeight*sin(fSphereAngle) + fHeightStart, fDirectionXZ, fDirectionYZ), fAngle);
        DelayCommand(f*fDelayPerSide, gao_ActionCreateLocalObject(sTemplate, lPos, "store" + IntToString(i), oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
        if (i > 0) DelayCommand(f*fDelayPerSide+fWait, gao_ActionApplyLocalBeamEffect(oData, "store" + IntToString(i-1), "store" + IntToString(i), nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamPolygonalHemisphere(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fRev=5.0f, float fTime=6.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamPolygonalHemisphere(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nSides, fDuration, sTemplate, fRev, fTime, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamStellaOctangula(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_STELLAOCTANGULA")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma = fRadius*2.0/3.0;
    float fEpsilon = fSigma*4.0/3.0/cos(19.47122063449069136924599933997);
    float fDelay = fTime/8.0;
    fWait += fDelay;
    float f, z, fAngle;
    location lPos;
    string sNumber, sNumber1;

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 8)));

    gao_ActionCreateLocalObject(sTemplate, lCenter, "store7", oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);

    for (i = 0; i < 7; i++)
    {
        f = IntToFloat(i);
        if (i < 3)
        {
            z = 2.0*fSigma;
            fAngle = fRotate + 120.0*f;
        }
        else if (i < 6)
        {
            z = fSigma;
            fAngle = fRotate + 120.0*f + 60.0;
        }
        else
        {
            z = 3.0*fSigma;
            fEpsilon = 0.0;
        }
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle), fEpsilon*sin(fAngle), z, fDirectionXZ, fDirectionYZ), fAngle);
        sNumber = "store"+IntToString(i);
        DelayCommand(fDelay*(f+1.0), gao_ActionCreateLocalObject(sTemplate, lPos, sNumber, oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    }

    for (i=0; i<3; i++)
    {
        f = IntToFloat(i);
        sNumber = "store"+IntToString(i);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, "store7", sNumber, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<6; i++)
    {
        f = IntToFloat(i+3);
        sNumber = "store"+IntToString(i);
        if (i==2)      sNumber1 = "store0";
        else if (i==5) sNumber1 = "store3";
        else           sNumber1 = "store"+IntToString(i+1);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber, sNumber1, nDurationType, nVFX, fDuration));
    }
    for (i=3; i<6; i++)
    {
        f = IntToFloat(i+6);
        sNumber = "store"+IntToString(i);
        sNumber1 = "store6";
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber, sNumber1, nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamStellaOctangula(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamStellaOctangula(nDurationType, nVFX, lCenter, fRadius, fDuration, sTemplate, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamIcosahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_ICOSAHEDRON")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma1 = fRadius*0.55278640450004206071816526625413;
    float fSigma2 = fRadius*0.89442719099991587856366946749173;
    float fEpsilon = fRadius*0.89442719099991587856366946749256;
    float fDelay = fTime/30.0;
    fWait += fDelay;
    float f, z, fAngle;
    location lPos;
    string sNumber, sNumber1;

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 12)));

    gao_ActionCreateLocalObject(sTemplate, lCenter, "store11", oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);

    for (i = 0; i < 11; i++)
    {
        f = IntToFloat(i);
        if (i < 5)
        {
            fAngle = fRotate + f*72.0;
            z = fSigma1;
        }
        else if (i < 10)
        {
            fAngle = fRotate + f*72.0 + 36.0;
            z = fSigma1 + fSigma2;
        }
        else
        {
            fAngle = fRotate;
            z = 2.0*fSigma1 + fSigma2;
            fEpsilon = 0.0;
        }
        lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle), fEpsilon*sin(fAngle), z, fDirectionXZ, fDirectionYZ), fAngle);
        sNumber = "store"+IntToString(i);
        DelayCommand(fDelay*(f+1.0), gao_ActionCreateLocalObject(sTemplate, lPos, sNumber, oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    }

    for (i=0; i<5; i++)
    {
        f = IntToFloat(i);
        sNumber = "store"+IntToString(i);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, "store11", sNumber, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<10; i++)
    {
        f = IntToFloat(i+5);
        sNumber = "store"+IntToString(i);
        if (i==4)      sNumber1 = "store0";
        else if (i==9) sNumber1 = "store5";
        else           sNumber1 = "store"+IntToString(i+1);

        if (i<5) DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber, sNumber1, nDurationType, nVFX, fDuration));
        else     DelayCommand(fDelay*(f+10.0)+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber, sNumber1, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<10; i++)
    {
        f = IntToFloat(i+10);
        sNumber = "store"+IntToString(i);
        if (i<5)       sNumber1 = "store"+IntToString(i+5);
        else if (i==9) sNumber1 = "store0";
        else           sNumber1 = "store"+IntToString(i-4);

        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber, sNumber1, nDurationType, nVFX, fDuration));
    }
    for (i=5; i<10; i++)
    {
        f = IntToFloat(i+20);
        sNumber = "store10";
        sNumber1 = "store"+IntToString(i);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber, sNumber1, nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamIcosahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamIcosahedron(nDurationType, nVFX, lCenter, fRadius, fDuration, sTemplate, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamDodecahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_DODECAHEDRON")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma1 = fRadius*0.205345527708233877044469071674; // Rd - rd
    float fSigma2 = fRadius*0.79465447229176612295553092832696; // rd
    float fSigma3 = fRadius*0.60706199820668622309539158142001; // Rp
    float fEpsilon = fRadius*0.98224694637684602281567027523513; //Rdisplace ~ Zdisplace, golden
    float fDelay = fTime/30.0;
    fWait += fDelay;
    float f, fAngle;
    location lPos;
    string sNumber1, sNumber2;

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 20)));

    for (i = 0; i < 20; i++)
    {
        f = IntToFloat(i);
        if (i<5)
        {
            fAngle = fRotate + f*72.0 - 36.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma3*cos(fAngle), fSigma3*sin(fAngle), fSigma1, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<10)
        {
            fAngle = fRotate + f*72.0 - 36.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle), fEpsilon*sin(fAngle), fSigma1 + fSigma3, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<15)
        {
            fAngle = fRotate + f*72.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon*cos(fAngle), fEpsilon*sin(fAngle), fSigma1 + fEpsilon, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else
        {
            fAngle = fRotate + f*72.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma3*cos(fAngle), fSigma3*sin(fAngle), fSigma1 + 2.0*fSigma2, fDirectionXZ, fDirectionYZ), fAngle);
        }
        sNumber1 = "store"+IntToString(i);
        DelayCommand(fDelay*f, gao_ActionCreateLocalObject(sTemplate, lPos, sNumber1, oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    }

    for (i=0; i<5; i++)
    {
        f = IntToFloat(i);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i<4) ? "store" + IntToString(i+1) : "store0";
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<15; i++)
    {
        f = (i<10) ? IntToFloat(i+5) : IntToFloat(i+10);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = "store" + IntToString(i+5);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=10; i<15; i++)
    {
        f = IntToFloat(i+5);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i<14) ? "store" + IntToString(i-4) : "store5";
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=15; i<20; i++)
    {
        f = IntToFloat(i+10);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i<19) ? "store" + IntToString(i+1) : "store15";
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamDodecahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamDodecahedron(nDurationType, nVFX, lCenter, fRadius, fDuration, sTemplate, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamTriacontahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_TRIACONTAHEDRON")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma1 = fRadius*0.55278640450004206071816526625413;
    float fSigma2 = fRadius*0.89442719099991587856366946749173;
    float fSigma3 = fRadius*0.205345527708233877044469071674;   //1  Rd - rd
    float fSigma4 = fRadius*0.79465447229176612295553092832696; //2 rd
    float fSigma5 = fRadius*0.60706199820668622309539158142001; //3  Rp
    float fEpsilon1 = fRadius*0.89442719099991587856366946749256;
    float fEpsilon2 = fRadius*0.98224694637684602281567027523513; //Rdisplace ~ Zdisplace, golden
    float fDelay = fTime/60.0;
    fWait += fDelay;
    float f, fAngle;
    location lPos;
    string sNumber1, sNumber2;

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 32)));

    gao_ActionCreateLocalObject(sTemplate, lCenter, "store31", oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);

    for (i = 0; i < 31; i++)
    {
        f = IntToFloat(i);
        if (i<5)
        {
            fAngle = fRotate + f*72.0 + 36.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma5*cos(fAngle), fSigma5*sin(fAngle), fSigma3, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<10)
        {
            fAngle = fRotate + f*72.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon1*cos(fAngle), fEpsilon1*sin(fAngle), fSigma1, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<15)
        {
            fAngle = fRotate + f*72.0 + 36.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon2*cos(fAngle), fEpsilon2*sin(fAngle), fSigma3 + fSigma5, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<20)
        {
            fAngle = fRotate + f*72.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon2*cos(fAngle), fEpsilon2*sin(fAngle), fSigma3 + fEpsilon2, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<25)
        {
            fAngle = fRotate + f*72.0 + 36.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fEpsilon1*cos(fAngle), fEpsilon1*sin(fAngle), fSigma1 + fSigma2, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<30)
        {
            fAngle = fRotate + f*72.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma5*cos(fAngle), fSigma5*sin(fAngle), fSigma3 + 2.0*fSigma4, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else
        {
            fAngle = fRotate;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, 0.0, 0.0, 2.0*fSigma1 + fSigma2, fDirectionXZ, fDirectionYZ), fAngle);
        }
        sNumber1 = "store"+IntToString(i);
        DelayCommand(fDelay*(f+1.0), gao_ActionCreateLocalObject(sTemplate, lPos, sNumber1, oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    }

    for (i=0; i<15; i++)
    {
        f = (i<10) ? IntToFloat(i) : IntToFloat(i+5);
        sNumber1 = (i<5) ? "store31" : "store" + IntToString(i-5);
        sNumber2 = "store" + IntToString(i);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=5; i<15; i++)
    {
        f = (i<10) ? IntToFloat(i+5) : IntToFloat(i+10) ;
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i==5) ? "store4" : (i==14) ? "store5" : (i<10) ? "store" + IntToString(i-6) : "store" + IntToString(i-4);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=5; i<15; i++)
    {
        f = IntToFloat(i+20);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = "store" + IntToString(i+10);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=15; i<30; i++)
    {
        f = (i<20) ? IntToFloat(i+20) : (i<25) ? IntToFloat(i+25) : IntToFloat(i+30);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i<25) ? "store" + IntToString(i+5) : "store30" ;
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=20; i<30; i++)
    {
        f = (i<20) ? IntToFloat(i+20) : IntToFloat(i+25) ;
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i==24) ? "store15" : (i==25) ? "store24" : (i<25) ? "store" + IntToString(i-4) : "store" + IntToString(i-6);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamTriacontahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamTriacontahedron(nDurationType, nVFX, lCenter, fRadius, fDuration, sTemplate, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamCuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_CUBOCTAHEDRON")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma = fRadius*0.70710678118654752440084436210485;
    float fEpsilon = fRadius - fSigma ;
    float fDelay = fTime/24.0;
    fWait += fDelay;
    float f, fAngle;
    location lPos;
    string sNumber1, sNumber2;

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 12)));

    for (i = 0; i < 12; i++)
    {
        f = IntToFloat(i);
        if (i<4)
        {
            fAngle = fRotate + f*90.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma*cos(fAngle), fSigma*sin(fAngle), fEpsilon, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<8)
        {
            fAngle = fRotate + f*90.0 + 45.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fRadius*cos(fAngle), fRadius*sin(fAngle), fRadius, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else
        {
            fAngle = fRotate + f*90.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma*cos(fAngle), fSigma*sin(fAngle), fRadius + fSigma, fDirectionXZ, fDirectionYZ), fAngle);
        }
        sNumber1 = "store"+IntToString(i);
        DelayCommand(fDelay*f, gao_ActionCreateLocalObject(sTemplate, lPos, sNumber1, oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    }

    for (i=0; i<4; i++)
    {
        f = IntToFloat(i);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i<3) ? "store" + IntToString(i+1) : "store0";
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<8; i++)
    {
        f = (i<4) ? IntToFloat(i+4) : IntToFloat(i+8) ;
        sNumber1 = "store" + IntToString(i);
        sNumber2 = "store" + IntToString(i+4);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<8; i++)
    {
        f = (i<4) ? IntToFloat(i+8) : IntToFloat(i+12);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i==0) ? "store7" : (i<4) ? "store" + IntToString(i+3) : (i==7) ? "store8" : "store" + IntToString(i+5);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=8; i<12; i++)
    {
        f = IntToFloat(i+12);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i<11) ? "store" + IntToString(i+1) : "store8";
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamCuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamCuboctahedron(nDurationType, nVFX, lCenter, fRadius, fDuration, sTemplate, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamSmallRhombicuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_SMALLRHOMBICUBOCTAHEDRON")
{
    int i;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float fSigma1 = fRadius*0.50544946512442356216037311029756;
    float fSigma2 = fRadius*0.93394883109446475957738040414503;
    float fEpsilon1 = fRadius*0.13714379053898318189115991804927;
    float fEpsilon2 = fRadius*0.71481348867318651189693394330755;
    float fDelay = fTime/48.0;
    fWait += fDelay;
    float f, z, fAngle;
    location lPos;
    string sNumber1, sNumber2;

    object oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 24)));

    for (i = 0; i < 24; i++)
    {
        f = IntToFloat(i);
        if (i<4)
        {
            fAngle = fRotate + f*90.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma1*cos(fAngle), fSigma1*sin(fAngle), fEpsilon1, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else if (i<20)
        {
            fAngle = fRotate + 27.5 + (f-4.0)*45.0;
            z = (i<12) ? fEpsilon1 + fSigma1 : fEpsilon1 + fEpsilon2 + fSigma1;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma2*cos(fAngle), fSigma2*sin(fAngle), z, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else
        {
            fAngle = fRotate + f*90.0;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fSigma1*cos(fAngle), fSigma1*sin(fAngle), fEpsilon1 + 2.0*fSigma1 + fEpsilon2, fDirectionXZ, fDirectionYZ), fAngle);
        }
        sNumber1 = "store"+IntToString(i);
        DelayCommand(fDelay*f, gao_ActionCreateLocalObject(sTemplate, lPos, sNumber1, oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    }

    for (i=0; i<24; i++)
    {
        f = (i<4) ? IntToFloat(i) : (i<12) ? IntToFloat(i+8) : (i<20) ? IntToFloat(i+16) : IntToFloat(i+24) ;
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i==3) ? "store0" : (i==11) ? "store4" : (i==19) ? "store12" : (i==23) ? "store20" : "store" + IntToString(i+1) ;
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<20; i++)
    {
        f = (i<4) ? IntToFloat(i*2+4) : (i<12) ? IntToFloat(i+16) : IntToFloat(i+24);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i<4) ? "store" + IntToString(i*2+4) : (i<12) ? "store" + IntToString(i+8) : (i==13||i== 15||i==17) ? "store" + IntToString(21+(i-13)/2) : (i==19) ? "store20" : (i==18) ? "store23" : "store" + IntToString(19+(i-10)/2);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<4; i++)
    {
        f = (i==0) ? 11.0 : IntToFloat((i-1)*2+5);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i==0) ? "store11" : "store" + IntToString(i*2+3);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamSmallRhombicuboctahedron(int nDurationType, int nVFX, location lCenter, float fRadius, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
    ObjectBeamSmallRhombicuboctahedron(nDurationType, nVFX, lCenter, fRadius, fDuration, sTemplate, fTime, fWait, fRotate, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}

object ObjectBeamGengon(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, float fTwist=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f, string sTag="PSC_B_GENGON")
{
    int i;
    if (nSides < 3) nSides = 3;
    if (fWait < 1.0) fWait = 1.0;
    if (fWait2 < 1.0) fWait2 = 1.0;
    if (fTime < 0.0) fTime = 6.0;
    if (fLifetime < 0.0) fLifetime = 0.0;
    if (sTemplate == "") sTemplate = "prc_invisobj";
    float fEta = 360.0/IntToFloat(nSides); // angle of segment
    float fDelay = fTime/IntToFloat(3*nSides); // delay per edge
    vector vCenter = GetPositionFromLocation(lCenter);
    object oArea = GetAreaFromLocation(lCenter);
    float f, fAngle;
    object oData;
    location lPos;
    fTwist += fRotate;
    fWait += fDelay;
    string sNumber1, sNumber2;

    oData = CreateObject(OBJECT_TYPE_PLACEABLE, "prc_invisobj", lCenter, FALSE, sTag);
    AssignCommand(oData, ActionDoCommand(SetLocalInt(oData, "storetotal", 2*nSides)));

    for (i = 0; i < 2*nSides; i++)
    {
        f = IntToFloat(i);
        if (i<nSides)
        {
            fAngle = fEta*f + fRotate;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fRadiusStart*cos(fAngle), fRadiusStart*sin(fAngle), fHeightStart, fDirectionXZ, fDirectionYZ), fAngle);
        }
        else
        {
            fAngle = fEta*f + fTwist;
            lPos = Location(oArea, gao_RotateVector(vCenter, sAxis, fRadiusEnd*cos(fAngle), fRadiusEnd*sin(fAngle), fHeightEnd, fDirectionXZ, fDirectionYZ), fAngle);
        }
        sNumber1 = "store"+IntToString(i);
        DelayCommand(fDelay*f, gao_ActionCreateLocalObject(sTemplate, lPos, sNumber1, oData, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime));
    }

    for (i=0; i<2*nSides; i++)
    {
        f = (i<nSides) ? IntToFloat(i) : IntToFloat(i+nSides);
        sNumber1 = "store" + IntToString(i);
        sNumber2 = (i==nSides-1) ? "store0" : (i==2*nSides-1) ? "store" + IntToString(nSides) : "store" + IntToString(i+1);
        DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }
    for (i=0; i<nSides; i++)
    {
         f = IntToFloat(i + nSides);
         sNumber1 = "store" + IntToString(i);
         sNumber2 = "store" + IntToString(i + nSides);
         DelayCommand(fDelay*f+fWait, gao_ActionApplyLocalBeamEffect(oData, sNumber1, sNumber2, nDurationType, nVFX, fDuration));
    }

    if (fLifetime > 0.0)
    {
        DestroyObject(oData, fLifetime + fTime + fWait + fWait2 + 5.0);
        return OBJECT_INVALID;
    }
    return oData;
}

void BeamGengon(int nDurationType, int nVFX, location lCenter, float fRadiusStart, float fRadiusEnd=0.0f, float fHeightStart=0.0f, float fHeightEnd=5.0f, int nSides=3, float fDuration=0.0f, string sTemplate="", float fTime=6.0f, float fWait=1.0f, float fRotate=0.0f, float fTwist=0.0f, string sAxis="z", float fDirectionXZ = 0.0f, float fDirectionYZ = 0.0f, int nDurationType2=-1, int nVFX2=-1, float fDuration2=0.0f, float fWait2=1.0f, float fLifetime=0.0f)
{
     ObjectBeamGengon(nDurationType, nVFX, lCenter, fRadiusStart, fRadiusEnd, fHeightStart, fHeightEnd, nSides, fDuration, sTemplate, fTime, fWait, fRotate, fTwist, sAxis, fDirectionXZ, fDirectionYZ, nDurationType2, nVFX2, fDuration2, fWait2, fLifetime);
}
