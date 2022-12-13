@extends('layout.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">

                <div class="card ">
                    <div class="card-header">
                        <h6>رقيم</h6>

                    </div>
                    <div class="body text-center">
                        @if (str_contains($res, 'nothing to commit') || str_contains($res, 'no changes added to commit'))
                            <div class="alert alert-success" role="alert">
                                اخر أصدار
                            </div>
                        @else
                            <div class="alert alert-warning" role="alert">
                                هناك تحديث متاح
                            </div>
                            <a href="{{ route('updated') }}"> تحديث
                            </a>
                        @endif

                    </div>

                </div>
            </div>
        </div>
    @endsection
