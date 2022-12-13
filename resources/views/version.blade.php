@extends('layout.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            @if (isset($success))
                <div class="alert-success">{{ $success }}</div>
            @endif
            <div class="col-md-8">

                <div class="card text-center">
                    <div class="card-header">
                        <h6>رقيم</h6>
                    </div>
                    <div class="body text-center">
                        <a class="btn btn-warning" href="{{ route('updated') }}"> بحث عن تحديث
                        </a>

                    </div>

                </div>
            </div>
        </div>
    @endsection
