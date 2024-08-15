namespace Promotion
{
    public class Contract
    {
        public string Number { get; set; }
        public int Code { get; set; }
        public string FIO { get; set; }
        public byte Seniority { get; set; }
        public byte Fights { get; set; }
        public decimal Fee { get; set; }
        public decimal Salary { get; set; }
        public decimal Compen { get; set; }
        public double Min { get; set; }
        public string SignDate { get; set; }
        public string EndDate { get; set; }
        public Contract(string number, int code, string fio, byte seniority, byte fights,
            decimal fee, decimal salary, decimal compen, double min, string signDate, string endDate)
        {
            Number = number; Code = code; FIO = fio; Seniority = seniority; Fights = fights;
            Fee = fee; Salary = salary; Compen = compen; Min = min; SignDate = signDate; EndDate = endDate;
        }
        public Contract() { }
    }
}
