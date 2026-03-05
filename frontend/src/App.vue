<script setup>
import { ref, onMounted } from 'vue'

const API_BASE = import.meta.env.VITE_API_BASE

const employees = ref([])
const seats = ref([])

const selectedEmpId = ref('')
const selectedSeatSeq = ref(null)

const loading = ref(false)

const loadEmployees = async () => {
  const res = await fetch(`${API_BASE}/api/employees`)

  if (!res.ok) {
    throw new Error('load employees failed')
  }

  employees.value = await res.json()
}

const loadSeats = async () => {
  const res = await fetch(`${API_BASE}/api/seats`)

  if (!res.ok) {
    throw new Error('loadSeats failed')
  }

  seats.value = await res.json()
}

const employeeHasSeat = () => {
  return seats.value.some(
      s => s.occupiedEmpId === selectedEmpId.value
  )
}

const onClickSeat = async (seat) => {

  // 如果是已佔用座位
  if (seat.occupiedEmpId) {

    const ok = confirm(`清除座位？(目前：${seat.occupiedEmpId})`)
    if (!ok) return

    loading.value = true
    try {
      await fetch(`${API_BASE}/api/seat/clear`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ floorSeatSeq: seat.floorSeatSeq })
      })

      await loadSeats()

    } finally {
      loading.value = false
    }

    return
  }

  // 空位才需要先選員工
  if (!selectedEmpId.value) {
    alert('請先選員工')
    return
  }

  // 點空位
  selectedSeatSeq.value = seat.floorSeatSeq
}

const onSubmitAssign = async () => {

  if (!selectedEmpId.value) {
    alert('請先選員工')
    return
  }
  if (!selectedSeatSeq.value) {
    alert('請先選座位')
    return
  }

  // 如果員工已有座位，先詢問
  if (employeeHasSeat()) {
    const ok = confirm('員工已經有座位，是否重新指派？')
    if (!ok) return
  }

  loading.value = true
  try {
    const res = await fetch(`${API_BASE}/api/seat/assign`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        empId: selectedEmpId.value,
        floorSeatSeq: selectedSeatSeq.value
      })
    })

    if (!res.ok) {
      throw new Error('assign seat failed')
    }

    // 送出才寫 DB，成功後清掉暫存選擇並重刷
    selectedSeatSeq.value = null
    await loadSeats()
  } finally {
    loading.value = false
  }
}

onMounted(async () => {
  try {
    await loadEmployees()
    await loadSeats()
  } catch (e) {
    alert('系統錯誤')
    console.error(e)
  }
})
</script>

<template>
  <div class="wrap">
    <h2>員工座位系統</h2>

    <!-- 上面：員工下拉 + 送出 -->
    <div class="top">
      <select v-model="selectedEmpId">
        <option value="">請選員工</option>
        <option v-for="e in employees" :key="e.empId" :value="e.empId">
          {{ e.empId }} - {{ e.name }}
        </option>
      </select>

      <button :disabled="loading" @click="onSubmitAssign">
        {{ loading ? '處理中...' : '送出' }}
      </button>

      <div class="legend">
        <span class="dot empty"></span> 空位
        <span class="dot occupied"></span> 已佔用
        <span class="dot selected"></span> 已選擇
      </div>
    </div>

    <!-- 中間：座位格子 -->
    <div class="grid">
      <div
          v-for="s in seats"
          :key="s.floorSeatSeq"
          class="seat"
          :class="{
          occupied: !!s.occupiedEmpId,
          selected: s.floorSeatSeq === selectedSeatSeq
        }"
          @click="onClickSeat(s)"
      >
        <div class="title">
          {{ s.floorNo }}樓:座位{{ s.seatNo }}<span v-if="s.occupiedEmpId">[員編:{{ s.occupiedEmpId }}]</span>
        </div>
      </div>
    </div>

<!--    <p class="hint">-->
<!--      規則：先選員工 → 點空位變綠色（暫存）→ 按「送出指派」才寫 DB。<br />-->
<!--      點紅色座位會詢問是否清除，確認後呼叫 /api/seat/clear。-->
<!--    </p>-->
  </div>
</template>

<style>
.wrap {
  padding: 24px;
  font-family: Arial, Helvetica, sans-serif;
}

.top {
  display:flex;
  gap:12px;
  align-items:center;
  flex-wrap:wrap;
}

select {
  padding:8px;
  min-width:220px;
}

button {
  padding: 8px 16px;
  cursor: pointer;
  background: #1976d2;
  color: white;
  border: none;
  border-radius: 4px;
}

button:hover {
  background: #1565c0;
}

.legend {
  display:flex;
  gap:10px;
  align-items:center;
  font-size:14px;
}

.dot {
  display:inline-block;
  width:12px;
  height:12px;
  border:1px solid #333;
  margin-right:4px;
  vertical-align:middle;
}

.dot.empty {
  background:#eee;
}

.dot.occupied {
  background:#ffaaaa;
}

.dot.selected {
  background:#aaffaa;
}

.grid {
  margin-top:30px;
  display:grid;
  grid-template-columns:repeat(4, minmax(180px, 1fr));
  gap:20px;
}

.seat {
  border-radius:6px;
  text-align:center;
  font-weight:600;
  padding:12px;
  white-space: nowrap;
}

.seat.occupied {
  background:#e60000;
  color:white;
}

.seat.selected {
  background:#7be08a;
}

.seat:not(.occupied):not(.selected) {
  background:#e0e0e0;
}

.title {
  font-weight:700;
  white-space: nowrap;
}

.emp {
  font-size:14px;
}

.hint {
  margin-top:16px;
  color:#444;
}
</style>