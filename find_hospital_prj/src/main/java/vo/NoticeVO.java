package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data	
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
	
	private int nno;
	private String title;
	private String content;
	private String w_date;
	
}
