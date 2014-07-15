/**
 * Copyright (c) BBP/EPFL 2005-2014
 *                        Stefan.Eilemann@epfl.ch
 * All rights reserved. Do not distribute without further notice.
 */

#include <zerobuf/world.h>
#include <zerobuf/schema_generated.h>
#include <eda1/version.h>

#include <iostream>

namespace zerobuf
{
void World::greet()
{
    std::cout << "Zerobuf world version " << eda1::Version::getRevString()
              << std::endl;
}

int World::getN( const int n )
{
    /// \todo Try harder
    /// \bug Only works for integers
    return n;
}

}
