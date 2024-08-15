namespace Promotion
{
    public class Award
    {
        public int Code { get; set; }
        public string FIO1 { get; set; }
        public string FIO2 { get; set; }
        public string Event { get; set; }
        public string Date { get; set; }
        public string AwardName { get; set; }
        public string Awarded { get; set; }
        public decimal Money { get; set; }
        public Award(int code, string fio1, string fio2, string tournament, string date, string award,
            string awarded, decimal money)
        {
            Code = code; FIO1 = fio1; FIO2 = fio2; Event = tournament; Date = date; AwardName = award;
            Awarded = awarded; Money = money;
        }
        public Award() { }
    }
}
