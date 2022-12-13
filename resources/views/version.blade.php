@extends('layout.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">

                <div class="card text-center">
                    <div class="card-header">
                        <h6>رقيم</h6>
                    </div>
                    <div class="body text-center">
                        <a class="btn btn-danger" href="{{ route('updated') }}"> بحث عن تحديث
                        </a>

                    </div>

                </div>
            </div>
        </div>
    @endsection
