library(rnetcarto)

context("Test the result of the C binding functions for a few simple networks.")

test_that("a simple network solved by hand give the same result", {

    ans <- .Call("CBipartmod",
                 c(0L,1L,2L,3L,0L,1L,2L,3L,1L),
                 c(0L,1L,2L,3L,1L,0L,3L,2L,2L),
                 c(1, 1, 1, 1, 1, 1, 1, 1, 1),
                 1L,
                 1.0,
                 .950,
                 0L,
                 1L,
                 1L
                 )
    expect_equal(ans[[1]][1],ans[[1]][2], label="Module 1")
    expect_equal(ans[[1]][3],ans[[1]][4], label="Module 2")
    expect_equal(ans[[2]],c(0,0,0,0), label="Z-score")
    expect_equal(ans[[3]],
                 c(0,0.5,0.444444,0.444444),
                 tolerance=0.01,
                 label="Participation Coefficient")
    expect_equal(ans[[4]],2*(2/12-6/81) + 2*(2/12 - 4/81),
                 label="Modularity")
})


test_that("another simple network solved by hand give the same result", {

    ans <- .Call("CBipartmod",
                 c(0L,0L,1L,2L,2L,3L,3L,3L,4L,5L,6L),
                 c(0L,1L,0L,0L,1L,0L,1L,2L,2L,2L,2L),
                 c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                 1L,
                 1.0,
                 .950,
                 0L,
                 1L,
                 1L
               )
    c(2,2,2,2,1,1,1)
    expect_equal(ans[[1]][1],ans[[1]][2], label="Module 1 (A/B)")
    expect_equal(ans[[1]][1],ans[[1]][3], label="Module 1 (A/C)")
    expect_equal(ans[[1]][1],ans[[1]][4], label="Module 1 (A/D)")
    expect_equal(ans[[1]][5],ans[[1]][6], label="Module 2 (E/F)")
    expect_equal(ans[[1]][5],ans[[1]][7], label="Module 2 (E/G)")
    expect_equal(ans[[2]],
                 tolerance=0.01,
                 c(0.57735027, -1.73205081,  0.57735027,  0.57735027,0,0,0),
                 label="Z-score")
    expect_equal(ans[[3]],
                 c(0,0,0,.46875,0.4444,0.4444,0.4444),
                 tolerance=0.01,
                 label="Participation Coefficient")
})

