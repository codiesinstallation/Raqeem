<template>
    <div v-if="bill && mixins">
        <a
            id="btn"
            class="btn btn-info text-light d-none"
            data-target="#printModal"
            data-toggle="modal"
            ><i class="fas fa-ellipsis-v"></i
        ></a>
        <div
            id="printModal"
            aria-hidden="true"
            aria-labelledby="printModal"
            class="modal fade"
            role="dialog"
            tabindex="-1"
        >
            <div
                class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
                role="document"
            >
                <div class="modal-content m-auto">
                    <div class="modal-header">
                        <button
                            aria-label="Close"
                            class="close"
                            data-dismiss="modal"
                            type="button"
                        >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div id="printMe" class="modal-body">
                        <div id="invoice-POS" class="pos-section">
                            <div id="top" style="text-align: center">
                                <div class="logo text-center">
                                    <img
                                        :src="mixins.mixins_logo"
                                        style="
                                            width: 50px;
                                            height: 50px;
                                            border-radius: 50%;
                                        "
                                    />
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.mixins_name }}
                                    </span>
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.contruct_no }}
                                    </span>
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.mixins_adress }}
                                    </span>
                                </div>
                                <div class="info">
                                    <span class="m-0">
                                        {{ mixins.mixins_mobile }}
                                    </span>
                                </div>
                                <!--End Info-->
                                <div
                                    v-if="bill.customer != null"
                                    class="text-center"
                                >
                                    <small
                                        v-if="
                                            bill.customer.cust_vat_num &&
                                            mixins.mixins_vat_val > 0
                                        "
                                    >
                                        ???????????? ????????????
                                    </small>
                                    <small v-else-if="mixins.mixins_vat_val > 0"
                                        >???????????? ???????????? ??????????</small
                                    >
                                </div>
                                <div v-else class="text-center">
                                    <small
                                        v-if="
                                            mixins.mixins_vat_val > 0 &&
                                            mixins.contruct_no
                                        "
                                    >
                                        ???????????? ???????????? ??????????</small
                                    >
                                </div>
                            </div>
                            <!--End InvoiceTop-->
                            <div id="bot">
                                <div id="table">
                                    <table
                                        id="resultTable"
                                        class="text-center w-100"
                                    >
                                        <tr>
                                            <td colspan="1" class="no-border">
                                                ?????? ????????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.bill_no }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="1" class="no-border">
                                                ?????????? ????????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{
                                                    moment(
                                                        bill.bill_date
                                                    ).format("DD-MM-YYYY")
                                                }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td
                                                colspan="1"
                                                class="no-border"
                                                v-if="bill.user != null"
                                            >
                                                ???????????? ????????????
                                            </td>
                                            <td
                                                colspan="3"
                                                class="no-border"
                                                v-if="bill.user != null"
                                            >
                                                {{ bill.user.name }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td
                                                colspan="1"
                                                class="no-border"
                                                v-if="bill.pay_methods != null"
                                            >
                                                ?????????? ??????????
                                            </td>
                                            <td
                                                colspan="3"
                                                class="no-border"
                                                v-if="bill.pay_methods != null"
                                            >
                                                {{
                                                    bill.pay_methods
                                                        .pay_method_name
                                                }}
                                            </td>
                                        </tr>
                                        <td colspan="4">
                                            <hr class="hr-line" />
                                        </td>
                                        <tr v-if="bill.customer">
                                            <td colspan="1" class="no-border">
                                                ?????? ????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_name }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.customer">
                                            <td colspan="1" class="no-border">
                                                ???????? ????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_mobile }}
                                            </td>
                                        </tr>

                                        <tr
                                            v-if="
                                                bill.customer &&
                                                bill.customer.cust_address
                                            "
                                        >
                                            <td colspan="1" class="no-border">
                                                ?????????? ????????????
                                            </td>

                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_address }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.customer &&
                                                bill.customer.cust_vat_num
                                            "
                                        >
                                            <td colspan="1" class="no-border">
                                                ?????????? ?????????????? ????????????
                                            </td>
                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_vat_num }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.customer">
                                            <td colspan="1" class="no-border">
                                                ???????? ????????????
                                            </td>

                                            <td colspan="3" class="no-border">
                                                {{ bill.customer.cust_balance }}
                                            </td>
                                        </tr>

                                        <tr class="text-center">
                                            <th style="width: 40%">
                                                ?????? ??????????
                                            </th>
                                            <th style="width: 20%">??????????</th>
                                            <th style="width: 20%">??????????</th>
                                            <th style="width: 20%">????????????????</th>
                                        </tr>
                                        <tr
                                            v-for="(
                                                type, index
                                            ) in bill.bill_type"
                                            :key="index"
                                            class="ErrorRow"
                                        >
                                            <td>
                                                {{ type.type.type_name_ar }}
                                                <small class="d-block">{{
                                                    type.type_note
                                                }}</small>
                                            </td>
                                            <td class="text-center">
                                                {{ type.type_count }}
                                            </td>

                                            <td class="text-center">
                                                {{ type.type_price }}
                                            </td>
                                            <td class="text-center">
                                                {{ type.type_total_price }}
                                            </td>
                                            <td class="d-none">
                                                <small class="d-block"></small>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="2" class="no-border">
                                                ??????????????:
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.bill_sum }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.bill_discount > 0">
                                            <td
                                                v-if="
                                                    bill.bill_discount_percent
                                                "
                                                colspan="2"
                                                class="no-border"
                                            >
                                                ??????????{{ bill.bill_discount }} %:
                                            </td>
                                            <td
                                                v-else
                                                colspan="2"
                                                class="no-border"
                                            >
                                                ??????????:
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.bill_discount }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.offer_discount > 0">
                                            <td colspan="2" class="no-border">
                                                ?????? ??????????
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.offer_discount }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.bill_extra > 0">
                                            <td colspan="2" class="no-border">
                                                ??????????????:
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.bill_extra }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.bill_vat_val > 0">
                                            <td colspan="2" class="no-border">
                                                ?????????? ???????????? ?????????????? ({{
                                                    mixins.mixins_vat_val
                                                }}%):
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.bill_vat_val }}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="no-border">
                                                ????????????????:
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.bill_total }}
                                            </td>
                                        </tr>
                                        <tr
                                            v-if="
                                                bill.bill_paid_val !=
                                                bill.bill_total
                                            "
                                        >
                                            <td colspan="2" class="no-border">
                                                ??????????????:
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.bill_paid_val }}
                                            </td>
                                        </tr>
                                        <tr v-if="bill.bill_remain_val != 0">
                                            <td colspan="2" class="no-border">
                                                ????????????:
                                            </td>
                                            <td colspan="2" class="no-border">
                                                {{ bill.bill_remain_val }}
                                            </td>
                                        </tr>
                                        <td colspan="4">
                                            {{ bill.bill_notes }}
                                        </td>
                                    </table>
                                </div>
                                <!--End Table-->
                                <div v-if="mixins.mixins_note">
                                    <ul class="navbar-nav row text-center">
                                        <li
                                            class="col-12"
                                            v-for="(
                                                note, index
                                            ) in mixins.mixins_note.split(',')"
                                            :key="index"
                                        >
                                            {{ note }}
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div
                                v-if="
                                    mixins.mixins_name != null &&
                                    !mixins.mixins_name.isEmpty &&
                                    mixins.contruct_no != null
                                "
                                class="text-center"
                            >
                                <img :src="qr" height="120" />
                            </div>
                            <!--End InvoiceBot-->
                        </div>
                        <!--End Invoice-->
                    </div>
                    <div class="modal-footer text-center">
                        <button
                            id="print"
                            class="btn btn-secondary"
                            data-dismiss="modal"
                            type="button"
                        >
                            ??????????
                        </button>
                        <button
                            id="printer"
                            data-dismiss="modal"
                            class="btn btn-success d-none"
                            @click="print()"
                        >
                            ??????????
                        </button>
                        <button
                            id="printOne"
                            class="btn btn-success"
                            @click="printOne()"
                        >
                            ??????????
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import moment from "moment";
import Cookie from "../Helpers/Cookie";

export default {
    async created() {
        if (!User.loggedIn()) {
            await this.$router.push("/");
        }
        await this.getMixins();
    },
    props: ["bill", "qr"],
    data() {
        return {
            isDone: false,
            mixins: {},
            moment: moment,
            printers: [
                {
                    printer: "",
                    type: "",
                    count: "",
                    note: "",
                },
            ],
        };
    },
    methods: {
        async getMixins() {
            await axios
                .get("/api/mixins/1")
                .then(({ data }) => {
                    this.mixins = data;
                })
                .catch((error) => console.log(error));
        },
        print() {

            let billCopy = Cookie.getCookie("copy") ?? 1;

            for (var count = 1; count <= billCopy; count++) {
                this.$htmlToPaper("printMe");
            }
        },
        printOne() {
            this.$htmlToPaper("printMe");
        },
    },
};
</script>

<style scoped></style>
