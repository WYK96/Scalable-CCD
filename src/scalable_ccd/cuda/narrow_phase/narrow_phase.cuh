#pragma once

#include <scalable_ccd/config.hpp>

#include <scalable_ccd/cuda/scalar.cuh>
#include <scalable_ccd/cuda/memory_handler.hpp>
#include <scalable_ccd/cuda/broad_phase/aabb.cuh>
#include <scalable_ccd/cuda/utils/device_matrix.cuh>

#include <thrust/device_vector.h>
#include <vector>

namespace scalable_ccd::cuda {

/// @brief Run the CCD narrow phase on the GPU
/// @param d_vertices_t0
/// @param d_vertices_t1
/// @param d_boxes The list of AABBs
/// @param d_overlaps The list of pairs of indices of the boxes that overlap
/// @param threads The number of threads to use for the GPU kernel
/// @param max_iterations The maximum number of iterations for the root-finding algorithm
/// @param tolerance The root-finding tolerance
/// @param minimum_separation_distance The minimum separation distance
/// @param allow_zero_toi If true, allow a time of impact of zero
/// @param memory_handler
/// @param result_list
/// @param toi
/// @return
void narrow_phase(
    const DeviceMatrix<Scalar>& d_vertices_t0,
    const DeviceMatrix<Scalar>& d_vertices_t1,
    const thrust::device_vector<AABB>& d_boxes,
    const thrust::device_vector<int2>& d_overlaps,
    const int threads,
    const int max_iter,
    const Scalar tol,
    const Scalar minimum_separation_distance,
    const bool allow_zero_toi,
    std::shared_ptr<MemoryHandler> memory_handler,
#ifdef SCALABLE_CCD_TOI_PER_QUERY
    std::vector<int>& result_list,
#endif
    Scalar& toi);

} // namespace scalable_ccd::cuda