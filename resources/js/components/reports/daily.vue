<template>
    <div>
        <!-- Datatables -->
        <div v-show="!loading">
            <div class="card" dir="rtl">
                <div class="card-header">
                    <h6 class="text-center d-block">تقرير اليوم</h6>

                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <button
                                class="nav-link active"
                                id="nav-home-tab"
                                data-toggle="tab"
                                data-target="#nav-home"
                                type="button"
                                role="tab"
                                aria-controls="nav-home"
                                aria-selected="true"
                            >
                                المبيعات
                            </button>
                            <button
                                class="nav-link"
                                id="nav-profile-tab"
                                data-toggle="tab"
                                data-target="#nav-profile"
                                type="button"
                                role="tab"
                                aria-controls="nav-profile"
                                aria-selected="false"
                            >
                                الشراء
                            </button>
                            <button
                                class="nav-link"
                                id="nav-returns-tab"
                                data-toggle="tab"
                                data-target="#nav-returns"
                                type="button"
                                role="tab"
                                aria-controls="nav-returns"
                                aria-selected="false"
                            >
                                المرتجعات
                            </button>
                            <button
                                class="nav-link"
                                id="nav-expenses-tab"
                                data-toggle="tab"
                                data-target="#nav-expenses"
                                type="button"
                                role="tab"
                                aria-controls="nav-expenses"
                                aria-selected="false"
                            >
                                الصروفات
                            </button>
                        </div>
                    </nav>
                </div>
                <div class="card-body">
                    <div class="tab-content" id="nav-tabContent">
                        <div
                            class="tab-pane fade show active"
                            id="nav-home"
                            role="tabpanel"
                            aria-labelledby="nav-home-tab"
                        >
                            <div class="card">
                                <div class="card-header">
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
                                                <option value="1600">
                                                    1600
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <datatable
                                        class="bills-table text-center"
                                        id="bills-table"
                                        :filter="filter"
                                        :columns="columns"
                                        :perPage="per_page"
                                        :data="bills"
                                    >
                                        <template
                                            slot-scope="{
                                                row,
                                                columns,
                                                pagination,
                                            }"
                                        >
                                            <tr>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ row.bill_no }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    {{ row.bill_sum }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    {{ row.bill_vat_val }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ row.bill_total }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{ row.bill_discount }}
                                                    <span
                                                        v-if="
                                                            row.bill_discount_percent
                                                        "
                                                        >%</span
                                                    >
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    {{ row.bill_paid_val }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    {{ row.bill_remain_val }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    {{ row.bill_date }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected'
                                                            : ''
                                                    "
                                                >
                                                    {{
                                                        row.pay_methods
                                                            ? row.pay_methods
                                                                  .pay_method_name
                                                            : ""
                                                    }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    {{
                                                        row.customer
                                                            ? row.customer
                                                                  .cust_name
                                                            : ""
                                                    }}
                                                </td>
                                                <td
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    {{
                                                        row.user
                                                            ? row.user.name
                                                            : ""
                                                    }}
                                                </td>
                                                <td
                                                    :title="row.bill_notes"
                                                    style="max-width: 100px"
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint  '
                                                            : 'hideMeInPrint '
                                                    "
                                                >
                                                    {{ row.bill_notes }}
                                                </td>
                                                <td
                                                    v-show="user.reprint_bill"
                                                    :class="
                                                        selected === row.bill_no
                                                            ? 'selected hideMeInPrint'
                                                            : 'hideMeInPrint'
                                                    "
                                                >
                                                    <a
                                                        class="btn btn-sm btn-success"
                                                        @click="print(row)"
                                                    >
                                                        <i
                                                            class="fa fa-print text-light"
                                                        ></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </template>
                                    </datatable>
                                </div>
                                <div class="card-footer my-0 py-0">
                                    <datatable-pager
                                        class="pagination justify-content-center"
                                        v-model="page"
                                        type="short"
                                        :per-page="per_page"
                                    >
                                    </datatable-pager>
                                    <Calculation
                                        :calc="calc_bills"
                                        colspan="2"
                                    />
                                </div>
                            </div>
                        </div>
                        <div
                            class="tab-pane fade"
                            id="nav-profile"
                            role="tabpanel"
                            aria-labelledby="nav-profile-tab"
                        >
                            <div class="card">
                                <div class="card-header">
                                    <div class="card-tools">
                                        <div class="input-group input-group-sm">
                                            <select
                                                class="form-control-sm"
                                                id="per_page"
                                                v-model="purchases_per_page"
                                            >
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                                <option value="200">200</option>
                                                <option value="400">400</option>
                                                <option value="800">800</option>
                                                <option value="1600">
                                                    1600
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <datatable
                                        name="purchases"
                                        class="bills-table text-center"
                                        id="bills-table"
                                        :columns="purchases_columns"
                                        :perPage="purchases_per_page"
                                        :data="purchases"
                                    >
                                    </datatable>
                                </div>
                                <div class="card-footer my-0 py-0">
                                    <datatable-pager
                                        name="purchases"
                                        class="pagination justify-content-center"
                                        v-model="purchases_page"
                                        type="short"
                                        :per-page="purchases_per_page"
                                    ></datatable-pager>
                                    <Calculation
                                        :calc="calc_purchase"
                                        colspan="2"
                                    />
                                </div>
                            </div>
                        </div>
                        <div
                            class="tab-pane fade"
                            id="nav-returns"
                            role="tabpanel"
                            aria-labelledby="nav-returns-tab"
                        >
                            <div class="card">
                                <div class="card-header">
                                    <div class="card-tools">
                                        <div class="input-group input-group-sm">
                                            <select
                                                class="form-control-sm"
                                                id="per_page"
                                                v-model="returns_per_page"
                                            >
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                                <option value="200">200</option>
                                                <option value="400">400</option>
                                                <option value="800">800</option>
                                                <option value="1600">
                                                    1600
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <datatable
                                        class="bills-table text-center"
                                        id="bills-table"
                                        :filter="filter"
                                        :columns="returns_columns"
                                        :perPage="returns_per_page"
                                        :data="returns"
                                        name="returns"
                                    >
                                    </datatable>
                                </div>
                                <div class="card-footer my-0 py-0">
                                    <datatable-pager
                                        name="returns"
                                        class="pagination justify-content-center"
                                        v-model="returns_page"
                                        type="short"
                                        :per-page="returns_per_page"
                                    ></datatable-pager>
                                    <tfoot>
                                        <tr>
                                            <th colspan="3" style="width: 10%">
                                                اجمالي جميع الفواتير
                                            </th>
                                            <th style="width: 10%">
                                                {{ calc_returns.total }}
                                            </th>
                                            <th colspan="3" style="width: 10%">
                                                اجمالي الضريبة
                                            </th>
                                            <th style="width: 10%">
                                                {{ calc_returns.Vat }}
                                            </th>
                                        </tr>
                                    </tfoot>
                                </div>
                            </div>
                        </div>
                        <div
                            class="tab-pane fade"
                            id="nav-expenses"
                            role="tabpanel"
                            aria-labelledby="nav-expenses-tab"
                        >
                            <div class="card">
                                <div class="card-header">
                                    <div class="card-tools">
                                        <div class="input-group input-group-sm">
                                            <select
                                                class="form-control-sm"
                                                id="per_page"
                                                v-model="expenses_per_page"
                                            >
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                                <option value="200">200</option>
                                                <option value="400">400</option>
                                                <option value="800">800</option>
                                                <option value="1600">
                                                    1600
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <datatable
                                        class="bills-table text-center"
                                        id="bills-table"
                                        :columns="expenses_columns"
                                        :perPage="expenses_per_page"
                                        :data="expenses"
                                        name="expenses"
                                    >
                                    </datatable>
                                </div>
                                <div class="card-footer my-0 py-0">
                                    <datatable-pager
                                        name="expenses"
                                        class="pagination justify-content-center"
                                        v-model="expenses_page"
                                        type="short"
                                        :per-page="expenses_per_page"
                                    ></datatable-pager>
                                    <Calculation
                                        :calc="calc_expense"
                                        colspan="2"
                                    />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- DataTable with Hover -->
        <Printer
            :bill="bill"
            :qr="qr"
            v-if="$root.$data.codies.printer_type === 1"
        />
        <A4Printer :bill="bill" :qr="qr" v-else />
    </div>
</template>

<script>
import Calculation from "./calculation.vue";
import Printer from "../printer";
import A4Printer from "../A4Printer.vue";
import { Invoice } from "@axenda/zatca";

export default {
    async created() {
        if (!User.loggedIn()) {
            this.$router.push("/");
        }
        await axios
            .get("/api/users/" + localStorage.getItem("user_id"))
            .then(({ data }) => (this.user = data))
            .catch((error) => console.log(error));
        await this.getMixins();

        this.columns = [
            {
                label:
                    this.$root.$data.codies.default_lang === "ar"
                        ? "رقم الفاتورة"
                        : "Bill Number",
            },

            { label: "Sum" },

            { label: "Vat" },

            { label: "Total" },

            { label: "Discount" },

            { label: "Paid" },

            { label: "Remain" },

            { label: "Bill Date" },

            { label: "Pay Methods" },

            { label: "Customer Name" },

            { label: "User Name" },

            { label: "Notes" },

            { label: "Print" },
        ];
        await this.daily();
    },
    data() {
        return {
            codies: {},
            title: "Types",
            user: {},
            filter: "",
            loading: true,
            bills: [],
            page: 1,
            columns: [],
            per_page: 25,
            purchases: [],
            purchases_page: 1,
            purchases_columns: [
                { label: "purchase_bill_no", field: "purchase_bill_no" },
            ],
            purchases_per_page: 25,
            returns: [],
            returns_page: 1,
            returns_columns: [{ label: "return_id", field: "return_id" }],
            returns_per_page: 25,
            expenses: [],
            expenses_page: 1,
            expenses_columns: [{ label: "id", field: "id" }],
            expenses_per_page: 25,
            calc_returns: {},
            calc_purchase: {},
            calc_expense: {},
            calc_bills: {},
            selected: "",
            bill: null,
            qr: "",
        };
    },
    methods: {
        async getMixins() {
            await axios
                .get("/api/mixins/1")
                .then(({ data }) => {
                    this.codies = data;
                })
                .catch((error) => console.log(error));
        },
        daily() {
            axios.get("api/daily").then(
                function (response) {
                    this.bills = response.data.bills;
                    this.expenses = response.data.expenses;
                    this.purchases = response.data.purchases;
                    this.returns = response.data.returns;
                    this.calc_returns = response.data.calc_returns;
                    this.calc_purchase = response.data.calc_purchase;
                    this.calc_expense = response.data.calc_expense;
                    this.calc_bills = response.data.Calc;
                    this.loading = false;
                }.bind(this)
            );
        },
        async print(bill) {
            this.bill = bill;
            if (this.bill != null) {
                const invoice = new Invoice({
                    sellerName: this.$root.$data.codies.mixins_name,
                    vatRegistrationNumber: this.$root.$data.codies.contruct_no,
                    invoiceTimestamp: this.bill.bill_date,
                    invoiceTotal: this.bill.bill_total,
                    invoiceVatTotal: this.bill.bill_vat_val,
                });
                this.qr = await invoice.render();
            }
            $("#btn").click();
        },
        downloads(type, name) {
            var wb = XLSX.utils.table_to_book(document.getElementById(name), {
                sheet: "sheet js",
            });
            return XLSX.writeFile(wb, name + "." + type);
        },
    },
    components: { Printer, Calculation, A4Printer },
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

table thead tr,
.card-header.codies-table {
    background-color: #009879 !important;
    color: #ffffff !important;
    text-align: center;
    font-weight: bolder;
}

.card-header.codies-table {
    margin-bottom: 10px;
}
.card-header.codies-table *,
.codies-table select,
.codies-table option {
    color: #ffffff !important;
}
.card-header.codies-table select,
.card-header.codies-table option {
    color: #009879 !important;
    font-weight: bolder;
}
</style>
