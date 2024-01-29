#pragma once

#include <scalable_ccd/cuda/stq/aabb.cuh>

#include <spdlog/spdlog.h>

namespace scalable_ccd::cuda::stq {

struct sort_aabb_x {
    __device__ bool operator()(const Aabb& a, const Aabb& b) const
    {
        return (a.min.x < b.min.x);
    }

    __device__ bool operator()(const Scalar3& a, const Scalar3& b) const
    {
        return (a.x < b.x);
    }

    __device__ bool operator()(const Scalar2& a, const Scalar2& b) const
    {
        return (a.x < b.x);
    }
};

void setup(int devId, int& smemSize, int& threads, int& nbox);

} // namespace scalable_ccd::cuda::stq