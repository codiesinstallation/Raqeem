<template>
    <div>
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card mb-4">
                    <form @keydown.enter.prevent @submit.prevent="update">
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between"
                        >

                            <h6 class="m-0 font-weight-bold text-primary">
                                تحديث بيانات العامل
                            </h6>
                            <button class="btn btn-primary" type="submit">
                                حفظ
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span
                                        id="basic-addon1"
                                        class="input-group-text"
                                        >اسم العامل</span
                                    >
                                </div>
                                <input
                                    aria-describedby="basic-addon1"
                                    aria-label="اسم العامل"
                                    class="form-control"
                                    v-model="form.name"
                                    placeholder="اسم العامل"
                                    type="text"
                                    required
                                />
                            </div>

                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span
                                        id="basic-addon2"
                                        class="input-group-text"
                                        >هاتف العامل</span
                                    >
                                </div>
                                <input
                                    aria-describedby="basic-addon2"
                                    aria-label="هاتف العامل"
                                    class="form-control"
                                    placeholder="هاتف العامل"
                                    v-model="form.mobile"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text"
                                        >راتب العامل</span
                                    >
                                </div>
                                <input
                                    aria-describedby="basic-addon2"
                                    aria-label="راتب العامل"
                                    class="form-control"
                                    placeholder="راتب العامل"
                                    v-model="form.salary"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        الباركود
                                        <button
                                            type="button"
                                            class="btn"
                                            @click="generateBarcode"
                                        >
                                            <i class="fa fa-sync"></i></button
                                    ></span>
                                </div>
                                <input
                                    aria-describedby="basic-addon2"
                                    class="form-control"
                                    v-model="form.pin_code"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        الوظيفة
                                    </span>
                                </div>
                                <input
                                    aria-describedby="basic-addon2"
                                    aria-label="الوظيفة "
                                    class="form-control"
                                    placeholder="الوظيفة "
                                    v-model="form.jop_title"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text"
                                        >عدد ساعات العمل</span
                                    >
                                </div>
                                <input
                                    aria-describedby="basic-addon2"
                                    aria-label="عدد ساعات العمل "
                                    class="form-control"
                                    placeholder="عدد ساعات العمل "
                                    v-model="form.work_hour_count"
                                    type="text"
                                />
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-append">
                                    <span class="input-group-text">
                                        سعر ساعة العمل</span
                                    >
                                </div>
                                <input
                                    aria-describedby="basic-addon2"
                                    aria-label="سعر ساعة العمل "
                                    class="form-control"
                                    placeholder="سعر ساعة العمل "
                                    v-model="form.hour_price"
                                    type="text"
                                />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/javascript">
export default {
    created() {
        if (!User.loggedIn()) {
            this.$router.push({ name: "/" });
        }
        let id = this.$route.params.id;
        axios
            .get("/api/workers/" + id)
            .then(({ data }) => (this.form = data))
            .catch((err) => console.log(err));
    },

    data() {
        return {
            form: {
                name: "",
                mobile: "",
                work_hour_count: 8,
                pin_code: "",
                hour_price: 0,
                jop_title: "",
                salary: 0,

                is_user: false,
            },

            errors: {},
        };
    },

    methods: {
         generateBarcode() {
            this.form.pin_code = "";
            var val1 = Math.floor(2000000 + Math.random() * 999);
            this.form.pin_code = 2 + this.form.id + val1;
        },
        update() {
            let id = this.$route.params.id;
            axios
                .patch("/api/workers/" + id, this.form)
                .then(() => {
                    this.$router.push({ name: "workers" });
                    Notification.success();
                })
                .catch((error) => (this.errors = error.response.data.errors));
        },
    },
};
</script>

<style type="text/css"></style>
