package com.cyanhu.back_end.entity.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class SingleSignInRecordVO {
    boolean isSignIn;
    int signInDay;
}
