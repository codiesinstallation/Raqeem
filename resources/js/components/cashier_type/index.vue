<template>
    <div>
        <div v-if="user.types">
            <!-- Datatables -->
            <div v-show="!loading">
                <div class="card" dir="rtl">
                    <div
                        class="card-header d-flex flex-row justify-content-between"
                    >
                        <h3 class="card-title">كل المنتجات</h3>

                        <div class="card-tools">
                            <div class="input-group input-group-sm">
                                <input
                                    type="text"
                                    class="form-control-sm"
                                    v-model="filter"
                                    :placeholder="__('Search')"
                                    @keydown="$event.stopImmediatePropagation()"
                                />
                            </div>
                        </div>
                        <div class="card-tools">
                            <div class="input-group input-group-sm">
                                <select
                                    class="form-control-sm"
                                    id="per_page"
                                    v-model="per_page"
                                >
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    <option value="200">200</option>
                                    <option value="400">400</option>
                                    <option value="800">800</option>
                                    <option value="1600">1600</option>
                                </select>
                            </div>
                        </div>
                        <div class="card-tools">
                            <div class="input-group input-group-sm">
                                <input
                                    class="form-check-input"
                                    type="checkbox"
                                    v-model="selectAll"
                                    id="flexCheckDefault"
                                />
                                <label
                                    class="form-check-label pointer"
                                    for="flexCheckDefault"
                                >
                                    {{ __("اختيار الكل") }}
                                </label>
                                <span class="mx-2" v-if="selectAll">
                                    <!-- You are currently selecting all -->
                                    {{ __("تم اختيار ") }}
                                    <strong>{{ checked.length }}</strong>
                                    {{ __(" صنف.") }}
                                </span>
                                <a
                                    v-if="checked.length > 0"
                                    class="btn btn-sm btn-danger card-link"
                                    href="#"
                                    onclick="confirm('Are you sure you wanna delete this Record?') || event.stopImmediatePropagation()"
                                    type="button"
                                    @click.prevent="deleteRecords"
                                >
                                    {{ __("حذف المحدد") }}
                                </a>
                            </div>
                        </div>
                        <div class="card-tools">
                            <i
                                class="fas fa-file-excel text-success"
                                style="cursor: pointer"
                                @click="downloads('xlsx', 'types-table')"
                            ></i>
                        </div>

                        <div class="card-link">
                            <router-link
                                v-show="user.create_type"
                                class="font-weight-bold text-primary"
                                to="/create"
                                >إضافة
                            </router-link>
                        </div>
                    </div>
                    <div class="card-body">
                        <datatable
                            class="types-table text-center"
                            id="types-table"
                            :filter="filter"
                            :columns="columns"
                            :perPage="per_page"
                            :data="types"
                        >
                            <template slot-scope="{ row, columns, pagination }">
                                <tr>
                                    <td>
                                        <input
                                            type="checkbox"
                                            :value="row.type_id"
                                            v-model="checked"
                                        />
                                    </td>
                                    <td v-if="!isNewbill">
                                        <button @click="printBarcode(row)">
                                            <i class="fa fa-barcode"></i>
                                        </button>
                                        <router-link
                                            v-show="user.edit_type"
                                            :to="{
                                                name: 'edit',
                                                params: {
                                                    id: row.type_id,
                                                },
                                            }"
                                            class="btn btn-sm btn-primary"
                                            ><i class="fa fa-edit"></i>
                                        </router-link>
                                        <a
                                            v-show="user.delete_type"
                                            class="btn btn-sm btn-danger"
                                            @click="deleteType(row.type_id)"
                                            ><i class="fa fa-trash"></i
                                        ></a>
                                    </td>
                                    <td v-else>
                                        <button
                                            type="button"
                                            class="btn btn-sm btn-primary"
                                            @click="addToCart(row)"
                                        >
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </td>
                                    <td class="sorting_1">
                                        {{ row.type_id }}
                                    </td>
                                    <td class="">
                                        {{ row.type_barcode }}
                                    </td>
                                    <td class="" style="overflow: auto">
                                        {{ row.type_name_ar }}
                                    </td>
                                    <td>{{ row.type_name_en }}</td>
                                    <td class="">
                                        <!-- Button trigger modal -->
                                        <button
                                            v-show="
                                                row.type_icon !== '' ||
                                                row.type_icon != null
                                            "
                                            :data-target="
                                                '#exampleModalCenter-' +
                                                row.type_id
                                            "
                                            class="btn btn-sm btn-primary"
                                            data-toggle="modal"
                                            type="button"
                                        >
                                            <i class="fa fa-search"></i>
                                        </button>
                                        <div
                                            :id="
                                                'exampleModalCenter-' +
                                                row.type_id
                                            "
                                            aria-hidden="true"
                                            aria-labelledby="exampleModalCenterTitle"
                                            class="modal fade"
                                            role="dialog"
                                            tabindex="-1"
                                        >
                                            <div
                                                class="modal-dialog modal-dialog-centered"
                                                role="document"
                                            >
                                                <div
                                                    class="modal-content"
                                                    style="width: 500px"
                                                >
                                                    <div
                                                        class="modal-body"
                                                        style="width: 500px"
                                                    >
                                                        <img
                                                            :src="row.type_icon"
                                                            style="
                                                                width: 100%;
                                                                height: 100%;
                                                            "
                                                        />
                                                    </div>
                                                    <div
                                                        class="modal-footer py-1"
                                                    >
                                                        <button
                                                            class="btn-sm btn btn-secondary"
                                                            data-dismiss="modal"
                                                            type="button"
                                                        >
                                                            إغلاق
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="">
                                        {{ row.type_purchases_price }}
                                    </td>
                                    <td class="">
                                        {{ row.type_sill_price }}
                                    </td>
                                    <td class="">
                                        {{ row.minimum_sill_price }}
                                    </td>

                                    <td class="">
                                        {{ row.type_discount_value }}
                                    </td>
                                    <td>
                                        {{
                                            row.type_stock
                                                ? row.type_stock
                                                      .mixins_type_stock
                                                : 0
                                        }}
                                    </td>
                                    <td>
                                        {{
                                            row.type_stock
                                                ? row.type_stock
                                                      .mixins_type_stock *
                                                  row.type_sill_price
                                                : 0
                                        }}
                                    </td>
                                    <td>
                                        {{
                                            row.type_stock
                                                ? row.type_stock
                                                      .mixins_type_stock *
                                                  row.type_purchases_price
                                                : 0
                                        }}
                                    </td>
                                    <td>{{ row.type_exp_date }}</td>
                                </tr>
                            </template>
                            <template name="no-result">
                                Nothing to see here
                            </template>
                        </datatable>
                    </div>
                    <div class="card-footer my-0 py-0">
                        <datatable-pager
                            class="pagination justify-content-center"
                            v-model="page"
                            type="short"
                            :per-page="per_page"
                        ></datatable-pager>
                    </div>
                </div>
                <div
                    id="printMe"
                    class="d-none text-center"
                    style="margin: auto"
                >
                    <img class="barcode" />
                </div>
            </div>
            <!-- DataTable with Hover -->

            <div v-show="loading" class="text-center" dir="rtl">
                <Spinner :title="title"></Spinner>
            </div>
        </div>
        <Security v-else></Security>
    </div>
</template>

<script>
import Spinner from "../spinner/mixinsSpinner.vue";
import Security from "../spinner/security";
import JsBarcode from "jsbarcode";

export default {
    components: { Security, Spinner },
    props: {
        isNewbill: Boolean,
        addToCart: Function,
    },

    async created() {
        if (!User.loggedIn()) {
            this.$router.push("/");
        }
        await axios
            .get("/api/users/" + localStorage.getItem("user_id"))
            .then(({ data }) => (this.user = data))
            .catch((error) => console.log(error));
        await this.allTypes();
        await axios
            .get("/api/barcodes/" + 1)
            .then(({ data }) => {
                this.barcode = data;
            })
            .catch((error) => console.log(error));
    },
    watch: {
        selectAll: function (value) {
            this.checked = [];
            if (value) {
                this.types.forEach((row) => {
                    this.checked.push(row.type_id);
                });
            } else {
                this.checked = [];
                this.selectAll = false;
            }
        },
    },
    data() {
        return {
            title: "Types",
            user: {},
            filter: "",
            sections: {},
            checked: [],
            selectPage: false,
            selectAll: false,

            types: [],
            searchTerm: "",
            loading: true,
            total: 1,
            page: 1,
            current_page: "",
            last_page: "",
            typeName: "",
            barcode: {},
            columns: [
                { label: "تحديد", },
                { label: "اعدادات", field: "type_id" },
                { label: "كود", field: "type_id" },
                { label: "باركود الصنف", field: "type_barcode" },
                { label: "اسم الصنف عربي", field: "type_name_ar" },
                { label: "سم الصنف انجليزي", field: "type_name_en" },
                { label: "صورة الصنف", field: "type_icon" },
                { label: "سعر الشراء", field: "" },
                { label: "سعر البيع", field: "" },
                { label: "أقل سعر البيع", field: "" },
                { label: "قيمة الخصم", field: "" },
                { label: "المخزون", field: "" },
                { label: "الاجمالي بسعر البيع", field: "" },
                { label: "الاجمالي بسعر الشراء", field: "" },
                { label: "تاريخ الصلاحية", field: "" },
            ],
            types: [],
            per_page: 25,
        };
    },
    computed: {
        filterSearch() {
            return this.types.filter((type) => {
                return type.type_name_ar.match(this.searchTerm);
            });
        },
    },
    methods: {
        allTypes() {
            axios.get("/item").then(
                function (response) {
                    this.types = response.data;
                    this.loading = false;
                }.bind(this)
            );
        },
        downloads(type, name) {
            var wb = XLSX.utils.table_to_book(document.getElementById(name), {
                sheet: "sheet js",
            });
            return XLSX.writeFile(wb, name + "." + type);
        },
        selectAllRecords() {
            axios.get("/api/cashier/types").then((response) => {
                this.checked = response.data;
                this.selectAll = !this.selectAll;
            });
        },

        deleteRecords() {
            axios
                .delete("/api/types/massDestroy/" + this.checked)
                .then((response) => {
                    if (response.status == 204) {
                        this.checked = [];
                        this.allTypes();
                    }
                });
        },
        isChecked(type_id) {
            return this.checked.includes(type_id);
        },
        async printBarcode(type) {
            let barcode = type.type_barcode;
            if (
                type.type_barcode == null ||
                type.type_barcode === "" ||
                type.type_barcode.length === 0
            ) {
                barcode = type.type_id;
            }
            JsBarcode(".barcode", barcode, {
                textAlign: this.barcode.textAlign,
                textPosition: this.barcode.textPosition,
                font: this.barcode.font,
                fontOptions: this.barcode.fontOptions,
                textMargin: this.barcode.textMargin,
                format: this.barcode.format,
                displayValue: this.barcode.displayValue,
                height: this.barcode.height,
                width: this.barcode.width,
                fontSize: this.barcode.fontSize,
                background: this.barcode.background,
                lineColor: this.barcode.lineColor,
                margin: this.barcode.margin,
                marginLeft: this.barcode.marginLeft,
                marginTop: this.barcode.marginTop,
                marginBottom: this.barcode.marginBottom,
                marginRight: this.barcode.marginRight,
                flat: this.barcode.flat,
            });
            this.$htmlToPaper("printMe");
        },
        findTypeByLike() {
            axios
                .get("/api/action/like/" + this.typeName)
                .then(({ data }) => {
                    this.types = data;
                })
                .catch((error) => console.log(error));
        },

        deleteType(id) {
            if (confirm("هل تريد الحذف؟لايمكن الاستعاده مره اخرى.")) {
                axios
                    .delete("/api/types/" + id)
                    .then((data) => {
                        if (data.data) {
                            this.types = this.types.filter((type) => {
                                return type.type_id !== id;
                            });
                            Notification.successMsg("تم الحذف بنجاح");
                        } else {
                            Notification.errorMsg(
                                "لايمكن حذف صنف مرتبط بفواتير أو عمليات"
                            );
                        }
                    })
                    .catch(() => {
                        Notification.error();
                    });
            }
        },
    },
};
</script>
<style>
.pagination ul {
    display: inline-block;
    padding-left: 0;
    margin: 20px 0;
    border-radius: 4px;
}
.pagination.justify-content-center li {
    margin: 3px;
    float: left;
    list-style: none;
    border: 1px solid #ddd;
    padding: 5px 15px;
    margin: 0;
}
table thead tr {
    background-color: #009879 !important;
    color: #ffffff !important;
    text-align: center;
    font-weight: bolder;
    padding: 10px !important;
}

.card-header {
    margin-bottom: 10px;
}
</style>
