module test_m
    use iso_fortran_env, only: int32, real32
    implicit none
    private
    ! This is a line of comment.

    integer, parameter :: i32 = int32
    integer, parameter :: sp = real32

    type, public :: stat_t
        integer(i32) :: num
    contains
        procedure, private :: init_sub
        generic :: init => init_sub
        procedure, private :: gen_rand_arr_sub
        generic :: gen_rand_arr => gen_rand_arr_sub
    end type stat_t

contains

    subroutine init_sub(this, num)
        class(stat_t) :: this
        integer(i32), intent(in) :: num

        this%num = num
    end subroutine init_sub

    subroutine gen_rand_arr_sub(this, arr)
        class(stat_t) :: this
        real(sp), intent(out) :: arr(this%num)

        call random_number(arr)
    end subroutine gen_rand_arr_sub

end module test_m

program main
    use test_m
    use iso_fortran_env, only: real32, int32
    implicit none

    type(stat_t) :: test
    integer(int32), parameter :: val = 5_int32
    real(real32), dimension(val) :: arr

    call test%init(val)
    call test%gen_rand_arr(arr)
    print "('Pseudo-random number array generated:')"
    print "('arr = [', 4(f8.6, ', '), f8.6, ']')", arr
end program main
